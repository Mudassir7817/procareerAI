from flask import Flask, request, jsonify
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
import PyPDF2

app = Flask(__name__)

# ---------------------------
# 1) Load Data
# ---------------------------
universities_df = pd.read_csv('universities.csv')
courses_df = pd.read_csv('courses.csv')
materials_df = pd.read_csv('study_materials.csv')
careers_df = pd.read_csv('careers.csv')  # New careers dataset

# Create combined text columns for similarity matching
universities_df['combined_text'] = universities_df['fields'].fillna('')
courses_df['combined_text'] = (
    courses_df['course_name'].fillna('') + " " +
    courses_df['topic'].fillna('') + " " +
    courses_df['platform'].fillna('')
)
materials_df['combined_text'] = materials_df['topic'].fillna('')
careers_df['combined_text'] = (
    careers_df['career_name'].fillna('') + " " +
    careers_df['related_field'].fillna('')
)

# ---------------------------
# 2) Build TF-IDF Models
# ---------------------------
tfidf_uni = TfidfVectorizer(stop_words='english')
tfidf_courses = TfidfVectorizer(stop_words='english')
tfidf_materials = TfidfVectorizer(stop_words='english')
tfidf_careers = TfidfVectorizer(stop_words='english')

uni_tfidf_matrix = tfidf_uni.fit_transform(universities_df['combined_text'])
courses_tfidf_matrix = tfidf_courses.fit_transform(courses_df['combined_text'])
materials_tfidf_matrix = tfidf_materials.fit_transform(materials_df['combined_text'])
careers_tfidf_matrix = tfidf_careers.fit_transform(careers_df['combined_text'])

def get_top_matches(user_text, df, tfidf, tfidf_matrix, top_n=3):
    """Return top_n items from df that best match user_text based on TF-IDF cosine similarity."""
    if not user_text.strip():
        return []
    user_vec = tfidf.transform([user_text])
    cosine_similarities = linear_kernel(user_vec, tfidf_matrix).flatten()
    top_indices = cosine_similarities.argsort()[-top_n:][::-1]
    return df.iloc[top_indices].to_dict(orient='records')

# For course recommendations
synonym_map = {
    "Software Engineering": "Web Development",
    "Artificial Intelligence": "AI Machine Learning",
    "Data Science": "Data Science"
}

# For skill gap analysis
# You can expand or load from a file if needed
master_skills = [
    "Python",
    "Dart",
    "Flutter",
    "Java",
    "JavaScript",
    "React",
    "Node.js",
    "Machine Learning",
    "Data Science",
    "SQL"
]

@app.route('/')
def home():
    return "Career Recommendation API Running!"

# ---------------------------
# Original "recommend" Endpoint
# ---------------------------
@app.route('/recommend', methods=['POST'])
def recommend():
    data = request.get_json()
    print("Received data:", data)

    if not data:
        return jsonify({"error": "No data provided"}), 400

    name = data.get('name', '').strip()
    age = data.get('age', '').strip()
    qualification = data.get('qualification', '').strip()
    interests = data.get('interests', [])

    if not name or not age or not qualification or not interests:
        return jsonify({"error": "Missing required fields"}), 400

    # For courses: map user interests using synonyms.
    mapped_interests = [synonym_map.get(i, i) for i in interests]
    courses_profile_text = f"{qualification} {' '.join(mapped_interests)}"
    # For careers: use the original interests
    careers_profile_text = f"{qualification} {' '.join(interests)}"

    print("Courses profile text:", courses_profile_text)
    print("Careers profile text:", careers_profile_text)

    recommended_universities = get_top_matches(
        courses_profile_text, universities_df, tfidf_uni, uni_tfidf_matrix, top_n=3
    )
    recommended_courses = get_top_matches(
        courses_profile_text, courses_df, tfidf_courses, courses_tfidf_matrix, top_n=3
    )
    recommended_materials = get_top_matches(
        courses_profile_text, materials_df, tfidf_materials, materials_tfidf_matrix, top_n=3
    )
    recommended_careers = get_top_matches(
        careers_profile_text, careers_df, tfidf_careers, careers_tfidf_matrix, top_n=3
    )

    return jsonify({
        "recommended_universities": recommended_universities,
        "recommended_courses": recommended_courses,
        "recommended_materials": recommended_materials,
        "recommended_careers": recommended_careers
    }), 200

# ---------------------------
# New "analyzeCV" Endpoint
# ---------------------------
@app.route('/analyzeCV', methods=['POST'])
def analyze_cv():
    # Check if a file was provided
    if 'file' not in request.files:
        return jsonify({"error": "No file part in the request"}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No file selected"}), 400

    # Optional: verify PDF
    if not file.filename.lower().endswith('.pdf'):
        return jsonify({"error": "Only PDF files are supported"}), 400

    try:
        # Read PDF with PyPDF2
        pdf_reader = PyPDF2.PdfReader(file)
        full_text = ""
        for page in pdf_reader.pages:
            page_text = page.extract_text() or ""
            full_text += page_text + " "

        # Lowercase the resume text
        resume_text = full_text.lower()

        print("Extracted PDF text:", full_text)


        # Skills in resume
        skills_you_have = [
            skill for skill in master_skills
            if skill.lower() in resume_text
        ]
        # Skills missing
        all_skills_set = set(master_skills)
        found_skills_set = set(skills_you_have)
        skills_to_learn = list(all_skills_set - found_skills_set)

        return jsonify({
            "skills_you_have": skills_you_have,
            "skills_you_need_to_learn": skills_to_learn
        }), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

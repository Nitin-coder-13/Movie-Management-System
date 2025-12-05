import streamlit as st
import mysql.connector
import pandas as pd

# ------------------------------------------------------------------
# 1. PAGE SETUP
# ------------------------------------------------------------------
st.set_page_config(layout="wide", page_title="Movie DBMS")

st.title("🎬 Movie Management System")
st.markdown("""
This project demonstrates a **Relational Database Management System** with:
- **3NF Normalization**
- **Complex SQL Joins**
- **Many-to-Many Relationships**
""")


# ------------------------------------------------------------------
# 2. DATABASE CONNECTION
# ------------------------------------------------------------------
# Uses st.secrets so your password is not visible in the code
def get_connection():
    return mysql.connector.connect(**st.secrets["mysql"])


# ------------------------------------------------------------------
# 3. THE APP TABS
# ------------------------------------------------------------------
tab1, tab2, tab3 = st.tabs(["🎥 All Movies (Joins)", "🎭 Cast Search", "✍️ Add Review"])

# --- TAB 1: SHOW MOVIES WITH DIRECTORS (JOIN QUERY) ---
with tab1:
    st.subheader("Master List: Movies & Directors")
    st.caption("This query performs an INNER JOIN between `Movies` and `Directors` tables.")

    try:
        conn = get_connection()
        # Complex Query 1: Join Movies and Directors
        sql = """
        SELECT 
            m.MovieID, 
            m.Title, 
            m.ReleaseYear, 
            m.Genre, 
            CONCAT(d.FirstName, ' ', d.LastName) AS Director_Name,
            d.Nationality
        FROM Movies m
        JOIN Directors d ON m.DirectorID = d.DirectorID
        ORDER BY m.ReleaseYear DESC;
        """
        df = pd.read_sql(sql, conn)
        st.dataframe(df, use_container_width=True)
        conn.close()
    except Exception as e:
        st.error(f"Error: {e}")

# --- TAB 2: CAST LOOKUP (MANY-TO-MANY) ---
with tab2:
    st.subheader("Find the Cast of a Movie")
    st.caption("This demonstrates the Many-to-Many relationship using the `Movie_Cast` junction table.")

    conn = get_connection()
    # Get list of movies for the dropdown
    movies_list = pd.read_sql("SELECT Title FROM Movies", conn)

    selected_movie = st.selectbox("Select a Movie:", movies_list['Title'])

    if st.button("Show Cast"):
        # Complex Query 2: Join 3 Tables (Movies -> Cast -> Actors)
        sql_cast = f"""
        SELECT 
            a.FirstName, 
            a.LastName, 
            mc.RoleName 
        FROM Actors a
        JOIN Movie_Cast mc ON a.ActorID = mc.ActorID
        JOIN Movies m ON mc.MovieID = m.MovieID
        WHERE m.Title = '{selected_movie}';
        """
        df_cast = pd.read_sql(sql_cast, conn)

        if not df_cast.empty:
            st.success(f"Found {len(df_cast)} actors in '{selected_movie}'")
            st.table(df_cast)
        else:
            st.warning("No cast information found for this movie.")
    conn.close()

# --- TAB 3: ADD A REVIEW (INSERT QUERY) ---
with tab3:
    st.subheader("Add a User Review")

    with st.form("review_form"):
        conn = get_connection()
        # Dropdown to pick movie ID
        movie_options = pd.read_sql("SELECT MovieID, Title FROM Movies", conn)
        # Create a dictionary to map Title -> ID
        movie_map = dict(zip(movie_options['Title'], movie_options['MovieID']))

        chosen_title = st.selectbox("Choose Movie:", movie_options['Title'])
        reviewer = st.text_input("Your Name:")
        rating = st.slider("Rating (0-10):", 0.0, 10.0, 5.0)
        comment = st.text_area("Comment:")

        submitted = st.form_submit_button("Submit Review")

        if submitted:
            try:
                # INSERT Query
                cursor = conn.cursor()
                # Determine new ReviewID (Simple logic for project: Max + 1)
                cursor.execute("SELECT MAX(ReviewID) FROM Reviews")
                result = cursor.fetchone()
                new_id = (result[0] or 0) + 1

                insert_sql = "INSERT INTO Reviews (ReviewID, MovieID, ReviewerName, Rating, Comment) VALUES (%s, %s, %s, %s, %s)"
                val = (new_id, movie_map[chosen_title], reviewer, rating, comment)

                cursor.execute(insert_sql, val)
                conn.commit()
                st.success("Review Added Successfully! Refresh to see it.")
            except Exception as e:
                st.error(f"Error adding review: {e}")
            finally:
                conn.close()

# Footer
st.markdown("---")
st.markdown("""
---
### 👨‍💻 Developed By:
- **Nitin Pandey** (Roll No: 46)
- **Ipshita Shrivastava** (Roll No: 37)
- **Sarthak Chaudhary** (Roll No: 47)
- ** Jayati Tripathi** (Roll No: 36)
""")
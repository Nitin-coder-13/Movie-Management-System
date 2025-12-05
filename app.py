import streamlit as st
import mysql.connector
import pandas as pd

st.title("🎬 Movie Management System")

# We will fill this in Step 4 with Cloud details
# For now, if connection fails, it just shows a message
try:
    # This tries to look for secrets (which we will set up online later)
    conn = mysql.connector.connect(**st.secrets["mysql"])
    st.success("Connected to Database!")

    # Simple Query to prove it works
    query = "SELECT * FROM Movies LIMIT 5"
    df = pd.read_sql(query, conn)
    st.dataframe(df)
except Exception as e:
    st.warning("Database not connected yet. Please set up secrets in Streamlit Cloud.")
    st.write(f"Error details: {e}")
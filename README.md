# Pokemon-Data-Analysis
This project is a SQL-based exploration of Pokémon stats and traits using a dataset modeled after the official Pokémon games. It features a series of SQL queries designed to answer insightful questions about Pokémon strengths, weaknesses, types, generations, capture difficulty, and more. The goal of this project is to improve SQL proficiency by working with a real-world themed dataset and performing data-driven analysis similar to what a game designer or analyst might explore.

## 🔧 Tools Used

Microsoft SQL Server Management Studio (SSMS)

T-SQL

Pokémon dataset from Kaggle: Pokémon Dataset (Gen 1–9)

## 📊 Key Features

Standardized data types and handled missing values in type columns

Identified the top 10 Pokémon by total base stats

Aggregated average HP, Attack, and Speed by primary type

Found the most common primary type across all Pokémon

Counted how many Pokémon are single-type vs dual-type

Listed Pokémon weak to 3 or more types (2x or higher effectiveness)

Listed Pokémon that resist 5 or more types (0.5x or lower effectiveness)

Found the generation with the highest average total base stats

Isolated Pokémon with strong base stats (>500) but low capture rates (<50)

Identified Legendary or Mythical Pokémon with Flying type (either primary or secondary)

Filtered Pokémon with over 100 Speed that are not Legendary or Mythical

## ▶️ How to Run This Project

Open PokemonDataAnalysis.sql in SQL Server Management Studio (SSMS)

Download the dataset from Kaggle and import it into your SQL Server instance:

Download the dataset here

Ensure your table is named PokemonData and includes relevant columns such as:

Base_Stats, HP, Attack, Defense, Sp_Attack, Sp_Defense, Speed, Type_1, Type_2, Is_Legendary, Is_Mythical, etc.

Run each query section by section. Each block is labeled and commented.

## 📚 Learning Takeaways

Through this project, I gained hands-on experience with:

Data cleaning techniques in SQL (handling nulls, blank fields, datatype normalization)

Using conditional aggregation with CASE WHEN to count qualifying traits

Grouping and sorting to identify trends across Pokémon types and generations

Writing clear, well-commented SQL code suitable for analysis and portfolio demonstration

Structuring SQL projects to resemble real analytical tasks in game development and design

import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV file into a Pandas DataFrame
file_path = 'testsummary.csv'  # Replace 'grades.csv' with the actual file path
df = pd.read_csv(file_path)

# Assuming 'PercentageMatching' is the column containing the grades
grades = df['MatchingOutputs']/df['TotalFilesMatched']
print(df['MatchingOutputs'], df['TotalFilesMatched'], grades)

# Create a histogram of the grades
plt.hist(grades, bins=30, edgecolor='k')  # Adjust the number of bins as needed

# Set plot labels and title
plt.xlabel('Percentage Matching')
plt.ylabel('Frequency')
plt.title('Percentage Matching Distribution')
plt.xticks(rotation=90)

# Display the histogram
plt.show()

# Save the histogram to a file (e.g., 'histogram.png')
plt.savefig('testsummary.png')

# Close the plot (optional)
plt.close()
import requests
import pandas as pd

# Read UniProt IDs from a TSV file
uniprot_ids_df = pd.read_csv('/data/leuven/350/vsc35090/thesis/uniprot_ids_proteins.tsv', sep='\t')
uniprot_ids = uniprot_ids_df['LeadProt']

# List to store results
results = []

# Iterate over each UniProt ID
for uniprot_id in uniprot_ids:
    # Construct the API endpoint with the UniProt ID
    api_url = f"http://iupred3.elte.hu/iupred3/{uniprot_id}"
    
    # Send the HTTP request
    response = requests.get(api_url)
    
    if response.status_code == 200:
        # Skip the first 7 lines and parse the rest as a DataFrame
        data = response.text.split('\n')[7:]
        data = data[:-4]
        # Split each element by comma to separate rows, and then split each row by tab to separate columns
        parsed_data = [row.split('\t') for row in ','.join(data).split(',')]
        
        # Create DataFrame
        df = pd.DataFrame(parsed_data[1:], columns=parsed_data[0])
        
        # Convert columns to numeric
        numeric_columns = ['IUPRED SCORE']
        df[numeric_columns] = df[numeric_columns].apply(pd.to_numeric)
        
        # Calculate the ratio of values above 0.5 divided by the total number of values
        above_threshold_count = (df['IUPRED SCORE'] > 0.5).sum()
        total_values = len(df['IUPRED SCORE'])
        ratio_above_threshold = above_threshold_count / total_values if total_values != 0 else 0
        
        # Append UniProt ID and ratio to results list
        results.append({'UniProt_ID': uniprot_id, 'Ratio_Above_0.5': ratio_above_threshold})
    else:
        print(f"Error retrieving data for UniProt ID: {uniprot_id}")

# Create DataFrame from results
results_df = pd.DataFrame(results)

# Print the results DataFrame
#print(results_df)

# Write results_df to a TSV file
results_df.to_csv('/data/leuven/350/vsc35090/thesis/iupred_scores_with_ratio.tsv', sep='\t', index=False)

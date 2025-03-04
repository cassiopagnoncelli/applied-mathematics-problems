import json
import numpy as np
import matplotlib.pyplot as plt

def load_website_network(file_path):
    """Load the website network from a JSON file."""
    with open(file_path, 'r') as f:
        data = json.load(f)
    return data['websites']

def create_adjacency_matrix(websites):
    """
    Create the adjacency matrix for the website network.
    
    In the adjacency matrix, M[i][j] = 1 if website j links to website i,
    and 0 otherwise.
    """
    n = len(websites)
    adjacency_matrix = np.zeros((n, n))
    
    # Create a mapping from website IDs to indices
    website_indices = {website['id']: i for i, website in enumerate(websites)}
    
    for i, website in enumerate(websites):
        for referrer in website['referrals_from']:
            j = website_indices[referrer]
            adjacency_matrix[i][j] = 1
    
    return adjacency_matrix, website_indices

def calculate_outgoing_links(adjacency_matrix):
    """Calculate the number of outgoing links for each website."""
    return np.sum(adjacency_matrix, axis=0)

def pagerank(websites, damping_factor=0.85, max_iterations=100, tolerance=1e-6):
    """
    Implement the PageRank algorithm.
    
    Args:
        websites: List of website dictionaries
        damping_factor: Probability of following a link (default: 0.85)
        max_iterations: Maximum number of iterations (default: 100)
        tolerance: Convergence tolerance (default: 1e-6)
        
    Returns:
        ranks: Final PageRank values for each website
        iterations: Number of iterations performed
        convergence: Whether the algorithm converged
    """
    n = len(websites)
    
    # Create adjacency matrix
    adjacency_matrix, website_indices = create_adjacency_matrix(websites)
    
    # Calculate outgoing links for each website
    outgoing_links = calculate_outgoing_links(adjacency_matrix)
    
    # Handle websites with no outgoing links (dangling nodes)
    # For such websites, we assume they link to all other websites
    for j in range(n):
        if outgoing_links[j] == 0:
            adjacency_matrix[:, j] = 1
            outgoing_links[j] = n
    
    # Normalize the adjacency matrix by outgoing links
    for j in range(n):
        adjacency_matrix[:, j] /= outgoing_links[j]
    
    # Initialize PageRank values
    ranks = np.ones(n) / n
    
    # Iteratively update PageRank values
    iterations = 0
    convergence = False
    
    for _ in range(max_iterations):
        iterations += 1
        
        # Calculate new ranks
        new_ranks = (1 - damping_factor) / n + damping_factor * np.dot(adjacency_matrix, ranks)
        
        # Check for convergence
        if np.linalg.norm(new_ranks - ranks, 1) < tolerance:
            convergence = True
            ranks = new_ranks
            break
        
        ranks = new_ranks
    
    # Create a mapping from indices back to website IDs
    index_to_website = {i: website_id for website_id, i in website_indices.items()}
    
    # Create the result dictionary
    result = {
        'ranks': {index_to_website[i]: float(rank) for i, rank in enumerate(ranks)},
        'iterations': iterations,
        'convergence': convergence
    }
    
    return result

def plot_pagerank_distribution(ranks):
    """Plot the distribution of PageRank values."""
    website_ids = list(ranks.keys())
    rank_values = list(ranks.values())
    
    # Sort by rank value (descending)
    sorted_indices = np.argsort(rank_values)[::-1]
    sorted_websites = [website_ids[i] for i in sorted_indices]
    sorted_ranks = [rank_values[i] for i in sorted_indices]
    
    plt.figure(figsize=(12, 6))
    plt.bar(sorted_websites, sorted_ranks)
    plt.xlabel('Website ID')
    plt.ylabel('PageRank Value')
    plt.title('PageRank Distribution')
    plt.xticks(rotation=90)
    plt.tight_layout()
    plt.savefig('pagerank_distribution.png')
    plt.close()

def main():
    # Load the website network
    websites = load_website_network('website_network.json')
    
    # Calculate PageRank
    result = pagerank(websites)
    
    # Print the top 10 websites by PageRank
    print("Top 10 websites by PageRank:")
    sorted_ranks = sorted(result['ranks'].items(), key=lambda x: x[1], reverse=True)
    for i, (website_id, rank) in enumerate(sorted_ranks[:10]):
        print(f"{i+1}. {website_id}: {rank:.6f}")
    
    print(f"\nNumber of iterations: {result['iterations']}")
    print(f"Convergence: {result['convergence']}")
    
    # Plot PageRank distribution
    plot_pagerank_distribution(result['ranks'])
    
    # Save the results to a JSON file
    output = {
        'pagerank': [{'id': website_id, 'rank': rank} for website_id, rank in sorted_ranks],
        'iterations': result['iterations'],
        'convergence': result['convergence']
    }
    
    with open('pagerank_results.json', 'w') as f:
        json.dump(output, f, indent=2)
    
    print("\nResults saved to 'pagerank_results.json'")

if __name__ == "__main__":
    main()


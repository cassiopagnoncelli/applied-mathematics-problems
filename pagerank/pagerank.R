# Load required libraries
library(jsonlite)
library(igraph)
library(ggplot2)
library(dplyr)

# Function to create the website network data
create_website_network <- function() {
  # Create a list to store the website data
  websites <- list()

  # Define the referrals for each website
  websites[[1]] <- list(id = "W1", initial_rank = 1.0, referrals_from = c("W3", "W7", "W12", "W25", "W38"))
  websites[[2]] <- list(id = "W2", initial_rank = 1.0, referrals_from = c("W5", "W9", "W15", "W27"))
  websites[[3]] <- list(id = "W3", initial_rank = 1.0, referrals_from = c("W6", "W11", "W20", "W45"))
  websites[[4]] <- list(id = "W4", initial_rank = 1.0, referrals_from = c("W1", "W8", "W13", "W22"))
  websites[[5]] <- list(id = "W5", initial_rank = 1.0, referrals_from = c("W2", "W17", "W24", "W41"))
  websites[[6]] <- list(id = "W6", initial_rank = 1.0, referrals_from = c("W9", "W14", "W26", "W39"))
  websites[[7]] <- list(id = "W7", initial_rank = 1.0, referrals_from = c("W10", "W23", "W35", "W47"))
  websites[[8]] <- list(id = "W8", initial_rank = 1.0, referrals_from = c("W4", "W16", "W28", "W42", "W49"))
  websites[[9]] <- list(id = "W9", initial_rank = 1.0, referrals_from = c("W2", "W12", "W31", "W43"))
  websites[[10]] <- list(id = "W10", initial_rank = 1.0, referrals_from = c("W5", "W18", "W33", "W50"))
  websites[[11]] <- list(id = "W11", initial_rank = 1.0, referrals_from = c("W7", "W19", "W29", "W44"))
  websites[[12]] <- list(id = "W12", initial_rank = 1.0, referrals_from = c("W1", "W21", "W36", "W48"))
  websites[[13]] <- list(id = "W13", initial_rank = 1.0, referrals_from = c("W3", "W9", "W15", "W30"))
  websites[[14]] <- list(id = "W14", initial_rank = 1.0, referrals_from = c("W6", "W17", "W27", "W39", "W46"))
  websites[[15]] <- list(id = "W15", initial_rank = 1.0, referrals_from = c("W8", "W20", "W32", "W45"))
  websites[[16]] <- list(id = "W16", initial_rank = 1.0, referrals_from = c("W4", "W22", "W37", "W49"))
  websites[[17]] <- list(id = "W17", initial_rank = 1.0, referrals_from = c("W10", "W24", "W40", "W50"))
  websites[[18]] <- list(id = "W18", initial_rank = 1.0, referrals_from = c("W2", "W11", "W25", "W38"))
  websites[[19]] <- list(id = "W19", initial_rank = 1.0, referrals_from = c("W5", "W14", "W33", "W47"))
  websites[[20]] <- list(id = "W20", initial_rank = 1.0, referrals_from = c("W7", "W16", "W28", "W41"))
  websites[[21]] <- list(id = "W21", initial_rank = 1.0, referrals_from = c("W3", "W12", "W30", "W44"))
  websites[[22]] <- list(id = "W22", initial_rank = 1.0, referrals_from = c("W8", "W18", "W31", "W46"))
  websites[[23]] <- list(id = "W23", initial_rank = 1.0, referrals_from = c("W1", "W9", "W26", "W42"))
  websites[[24]] <- list(id = "W24", initial_rank = 1.0, referrals_from = c("W6", "W13", "W29", "W48"))
  websites[[25]] <- list(id = "W25", initial_rank = 1.0, referrals_from = c("W10", "W19", "W34", "W43"))
  websites[[26]] <- list(id = "W26", initial_rank = 1.0, referrals_from = c("W2", "W15", "W32", "W50"))
  websites[[27]] <- list(id = "W27", initial_rank = 1.0, referrals_from = c("W5", "W11", "W36", "W45"))
  websites[[28]] <- list(id = "W28", initial_rank = 1.0, referrals_from = c("W4", "W17", "W35", "W49"))
  websites[[29]] <- list(id = "W29", initial_rank = 1.0, referrals_from = c("W7", "W14", "W30", "W47"))
  websites[[30]] <- list(id = "W30", initial_rank = 1.0, referrals_from = c("W1", "W13", "W38", "W46"))
  websites[[31]] <- list(id = "W31", initial_rank = 1.0, referrals_from = c("W3", "W16", "W33", "W43"))
  websites[[32]] <- list(id = "W32", initial_rank = 1.0, referrals_from = c("W6", "W18", "W37", "W48"))
  websites[[33]] <- list(id = "W33", initial_rank = 1.0, referrals_from = c("W9", "W20", "W40", "W44"))
  websites[[34]] <- list(id = "W34", initial_rank = 1.0, referrals_from = c("W2", "W21", "W39", "W50"))
  websites[[35]] <- list(id = "W35", initial_rank = 1.0, referrals_from = c("W8", "W22", "W41", "W49"))
  websites[[36]] <- list(id = "W36", initial_rank = 1.0, referrals_from = c("W4", "W23", "W42", "W47"))
  websites[[37]] <- list(id = "W37", initial_rank = 1.0, referrals_from = c("W7", "W24", "W43", "W46"))
  websites[[38]] <- list(id = "W38", initial_rank = 1.0, referrals_from = c("W10", "W26", "W44", "W48"))
  websites[[39]] <- list(id = "W39", initial_rank = 1.0, referrals_from = c("W1", "W12", "W28", "W45", "W50"))
  websites[[40]] <- list(id = "W40", initial_rank = 1.0, referrals_from = c("W3", "W19", "W31", "W46"))
  websites[[41]] <- list(id = "W41", initial_rank = 1.0, referrals_from = c("W5", "W15", "W27", "W49"))
  websites[[42]] <- list(id = "W42", initial_rank = 1.0, referrals_from = c("W6", "W21", "W34", "W47"))
  websites[[43]] <- list(id = "W43", initial_rank = 1.0, referrals_from = c("W9", "W16", "W29", "W48"))
  websites[[44]] <- list(id = "W44", initial_rank = 1.0, referrals_from = c("W11", "W25", "W35", "W50"))
  websites[[45]] <- list(id = "W45", initial_rank = 1.0, referrals_from = c("W2", "W17", "W32", "W46"))
  websites[[46]] <- list(id = "W46", initial_rank = 1.0, referrals_from = c("W4", "W13", "W30", "W49"))
  websites[[47]] <- list(id = "W47", initial_rank = 1.0, referrals_from = c("W7", "W18", "W33", "W45"))
  websites[[48]] <- list(id = "W48", initial_rank = 1.0, referrals_from = c("W1", "W10", "W22", "W36"))
  websites[[49]] <- list(id = "W49", initial_rank = 1.0, referrals_from = c("W5", "W14", "W24", "W38", "W44"))
  websites[[50]] <- list(id = "W50", initial_rank = 1.0, referrals_from = c("W3", "W8", "W19", "W27", "W41"))

  # Return the website data
  return(list(websites = websites))
}

# Save the website network to a JSON file
save_website_network <- function(data, file_path) {
  write_json(data, file_path, pretty = TRUE)
}

# Create an igraph network from the website data
create_graph_from_websites <- function(websites) {
  # Extract all unique website IDs
  all_ids <- sapply(websites, function(w) w$id)

  # Create an edge list for the graph
  edges <- data.frame(from = character(0), to = character(0))

  # For each website, add edges from its referrers to it
  for (website in websites) {
    if (length(website$referrals_from) > 0) {
      new_edges <- data.frame(
        from = website$referrals_from,
        to = rep(website$id, length(website$referrals_from))
      )
      edges <- rbind(edges, new_edges)
    }
  }

  # Create the graph
  g <- graph_from_data_frame(edges, directed = TRUE, vertices = all_ids)

  return(g)
}

# Calculate PageRank using igraph
calculate_pagerank <- function(g, damping = 0.85, iterations = 100) {
  # Calculate PageRank with igraph
  pr <- page_rank(g, algo = "prpack", damping = damping)

  # Extract and format the results
  results <- data.frame(
    id = names(pr$vector),
    rank = as.numeric(pr$vector),
    stringsAsFactors = FALSE
  )

  # Sort by rank (descending)
  results <- results[order(-results$rank), ]

  return(list(
    ranks = results,
    iterations = iterations,
    convergence = TRUE
  ))
}

# Calculate PageRank manually
calculate_pagerank_manual <- function(websites, damping_factor = 0.85, max_iterations = 100, tolerance = 1e-6) {
  n <- length(websites)
  website_ids <- sapply(websites, function(w) w$id)

  # Create ID to index mapping
  id_to_index <- setNames(1:n, website_ids)

  # Initialize adjacency matrix
  # M[i,j] = 1 if website j links to website i
  M <- matrix(0, nrow = n, ncol = n)

  # Fill the adjacency matrix
  for (i in 1:n) {
    referrers <- websites[[i]]$referrals_from
    if (length(referrers) > 0) {
      for (referrer in referrers) {
        j <- id_to_index[referrer]
        M[i, j] <- 1
      }
    }
  }

  # Calculate outgoing links for each website
  out_links <- colSums(M)

  # Handle dangling nodes (websites with no outgoing links)
  for (j in 1:n) {
    if (out_links[j] == 0) {
      M[, j] <- rep(1, n)
      out_links[j] <- n
    }
  }

  # Normalize the columns of M
  for (j in 1:n) {
    M[, j] <- M[, j] / out_links[j]
  }

  # Initialize the rank vector
  r <- rep(1/n, n)

  # Power iteration
  converged <- FALSE
  iter <- 0

  for (i in 1:max_iterations) {
    iter <- i

    # Calculate new rank
    r_new <- (1 - damping_factor) / n + damping_factor * (M %*% r)

    # Check for convergence
    diff <- sum(abs(r_new - r))
    if (diff < tolerance) {
      converged <- TRUE
      r <- r_new
      break
    }

    r <- r_new
  }

  # Create results data frame
  results <- data.frame(
    id = website_ids,
    rank = as.vector(r),
    stringsAsFactors = FALSE
  )

  # Sort by rank (descending)
  results <- results[order(-results$rank), ]

  return(list(
    ranks = results,
    iterations = iter,
    convergence = converged
  ))
}

# Visualize PageRank results
plot_pagerank_results <- function(results) {
  # Only take the top 20 websites for clarity
  top_results <- results$ranks[1:20, ]

  # Create the plot
  p <- ggplot(top_results, aes(x = reorder(id, -rank), y = rank)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    geom_text(aes(label = sprintf("%.6f", rank)),
              hjust = -0.1, angle = 90, size = 3) +
    labs(title = "Top 20 Websites by PageRank",
         x = "Website ID",
         y = "PageRank Value") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  return(p)
}

# Compare manual PageRank with igraph PageRank
compare_pagerank_methods <- function(manual, igraph_pr) {
  # Join the results
  manual_df <- manual$ranks %>%
    rename(manual_rank = rank)

  igraph_df <- igraph_pr$ranks %>%
    rename(igraph_rank = rank)

  comparison <- inner_join(manual_df, igraph_df, by = "id")

  # Calculate correlation
  correlation <- cor(comparison$manual_rank, comparison$igraph_rank)

  # Create comparison plot
  p <- ggplot(comparison, aes(x = manual_rank, y = igraph_rank)) +
    geom_point() +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
    labs(title = paste("PageRank Method Comparison (Correlation:", round(correlation, 4), ")"),
         x = "Manual PageRank",
         y = "igraph PageRank") +
    theme_minimal()

  return(list(
    comparison = comparison,
    correlation = correlation,
    plot = p
  ))
}

# Main function to run the analysis
main <- function() {
  # Create the website network
  network_data <- create_website_network()

  # Save it to a JSON file
  save_website_network(network_data, "website_network.json")

  # Create graph from website data
  g <- create_graph_from_websites(network_data$websites)

  # Calculate PageRank using igraph
  pr_igraph <- calculate_pagerank(g)

  # Calculate PageRank manually
  pr_manual <- calculate_pagerank_manual(network_data$websites)

  # Print results
  cat("PageRank Results (igraph):\n")
  print(head(pr_igraph$ranks, 10))

  cat("\nPageRank Results (manual):\n")
  print(head(pr_manual$ranks, 10))

  cat("\nManual PageRank Iterations:", pr_manual$iterations, "\n")
  cat("Manual PageRank Convergence:", pr_manual$convergence, "\n")

  # Plot the results
  plot_igraph <- plot_pagerank_results(pr_igraph)
  print(plot_igraph)

  # Compare methods
  comparison <- compare_pagerank_methods(pr_manual, pr_igraph)
  print(comparison$plot)

  # Save results to CSV
  write.csv(pr_manual$ranks, "pagerank_results_manual.csv", row.names = FALSE)
  write.csv(pr_igraph$ranks, "pagerank_results_igraph.csv", row.names = FALSE)

  # Return all results
  return(list(
    network = network_data,
    graph = g,
    pagerank_igraph = pr_igraph,
    pagerank_manual = pr_manual,
    comparison = comparison
  ))
}

# Run the analysis
results <- main()

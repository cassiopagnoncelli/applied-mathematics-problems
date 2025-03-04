import React, { useState, useEffect } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import * as math from 'mathjs';

const PageRankVisualizer = () => {
  const [websiteData, setWebsiteData] = useState(null);
  const [pageRankResults, setPageRankResults] = useState(null);
  const [iterations, setIterations] = useState(0);
  const [dampingFactor, setDampingFactor] = useState(0.85);
  const [maxIterations, setMaxIterations] = useState(100);
  const [tolerance, setTolerance] = useState(0.000001);
  const [loading, setLoading] = useState(false);

  // Load the network data
  useEffect(() => {
    const networkData = {
      "websites": [
        {"id": "W1", "initial_rank": 1.0, "referrals_from": ["W3", "W7", "W12", "W25", "W38"]},
        {"id": "W2", "initial_rank": 1.0, "referrals_from": ["W5", "W9", "W15", "W27"]},
        {"id": "W3", "initial_rank": 1.0, "referrals_from": ["W6", "W11", "W20", "W45"]},
        {"id": "W4", "initial_rank": 1.0, "referrals_from": ["W1", "W8", "W13", "W22"]},
        {"id": "W5", "initial_rank": 1.0, "referrals_from": ["W2", "W17", "W24", "W41"]},
        {"id": "W6", "initial_rank": 1.0, "referrals_from": ["W9", "W14", "W26", "W39"]},
        {"id": "W7", "initial_rank": 1.0, "referrals_from": ["W10", "W23", "W35", "W47"]},
        {"id": "W8", "initial_rank": 1.0, "referrals_from": ["W4", "W16", "W28", "W42", "W49"]},
        {"id": "W9", "initial_rank": 1.0, "referrals_from": ["W2", "W12", "W31", "W43"]},
        {"id": "W10", "initial_rank": 1.0, "referrals_from": ["W5", "W18", "W33", "W50"]},
        {"id": "W11", "initial_rank": 1.0, "referrals_from": ["W7", "W19", "W29", "W44"]},
        {"id": "W12", "initial_rank": 1.0, "referrals_from": ["W1", "W21", "W36", "W48"]},
        {"id": "W13", "initial_rank": 1.0, "referrals_from": ["W3", "W9", "W15", "W30"]},
        {"id": "W14", "initial_rank": 1.0, "referrals_from": ["W6", "W17", "W27", "W39", "W46"]},
        {"id": "W15", "initial_rank": 1.0, "referrals_from": ["W8", "W20", "W32", "W45"]},
        {"id": "W16", "initial_rank": 1.0, "referrals_from": ["W4", "W22", "W37", "W49"]},
        {"id": "W17", "initial_rank": 1.0, "referrals_from": ["W10", "W24", "W40", "W50"]},
        {"id": "W18", "initial_rank": 1.0, "referrals_from": ["W2", "W11", "W25", "W38"]},
        {"id": "W19", "initial_rank": 1.0, "referrals_from": ["W5", "W14", "W33", "W47"]},
        {"id": "W20", "initial_rank": 1.0, "referrals_from": ["W7", "W16", "W28", "W41"]},
        {"id": "W21", "initial_rank": 1.0, "referrals_from": ["W3", "W12", "W30", "W44"]},
        {"id": "W22", "initial_rank": 1.0, "referrals_from": ["W8", "W18", "W31", "W46"]},
        {"id": "W23", "initial_rank": 1.0, "referrals_from": ["W1", "W9", "W26", "W42"]},
        {"id": "W24", "initial_rank": 1.0, "referrals_from": ["W6", "W13", "W29", "W48"]},
        {"id": "W25", "initial_rank": 1.0, "referrals_from": ["W10", "W19", "W34", "W43"]},
        {"id": "W26", "initial_rank": 1.0, "referrals_from": ["W2", "W15", "W32", "W50"]},
        {"id": "W27", "initial_rank": 1.0, "referrals_from": ["W5", "W11", "W36", "W45"]},
        {"id": "W28", "initial_rank": 1.0, "referrals_from": ["W4", "W17", "W35", "W49"]},
        {"id": "W29", "initial_rank": 1.0, "referrals_from": ["W7", "W14", "W30", "W47"]},
        {"id": "W30", "initial_rank": 1.0, "referrals_from": ["W1", "W13", "W38", "W46"]},
        {"id": "W31", "initial_rank": 1.0, "referrals_from": ["W3", "W16", "W33", "W43"]},
        {"id": "W32", "initial_rank": 1.0, "referrals_from": ["W6", "W18", "W37", "W48"]},
        {"id": "W33", "initial_rank": 1.0, "referrals_from": ["W9", "W20", "W40", "W44"]},
        {"id": "W34", "initial_rank": 1.0, "referrals_from": ["W2", "W21", "W39", "W50"]},
        {"id": "W35", "initial_rank": 1.0, "referrals_from": ["W8", "W22", "W41", "W49"]},
        {"id": "W36", "initial_rank": 1.0, "referrals_from": ["W4", "W23", "W42", "W47"]},
        {"id": "W37", "initial_rank": 1.0, "referrals_from": ["W7", "W24", "W43", "W46"]},
        {"id": "W38", "initial_rank": 1.0, "referrals_from": ["W10", "W26", "W44", "W48"]},
        {"id": "W39", "initial_rank": 1.0, "referrals_from": ["W1", "W12", "W28", "W45", "W50"]},
        {"id": "W40", "initial_rank": 1.0, "referrals_from": ["W3", "W19", "W31", "W46"]},
        {"id": "W41", "initial_rank": 1.0, "referrals_from": ["W5", "W15", "W27", "W49"]},
        {"id": "W42", "initial_rank": 1.0, "referrals_from": ["W6", "W21", "W34", "W47"]},
        {"id": "W43", "initial_rank": 1.0, "referrals_from": ["W9", "W16", "W29", "W48"]},
        {"id": "W44", "initial_rank": 1.0, "referrals_from": ["W11", "W25", "W35", "W50"]},
        {"id": "W45", "initial_rank": 1.0, "referrals_from": ["W2", "W17", "W32", "W46"]},
        {"id": "W46", "initial_rank": 1.0, "referrals_from": ["W4", "W13", "W30", "W49"]},
        {"id": "W47", "initial_rank": 1.0, "referrals_from": ["W7", "W18", "W33", "W45"]},
        {"id": "W48", "initial_rank": 1.0, "referrals_from": ["W1", "W10", "W22", "W36"]},
        {"id": "W49", "initial_rank": 1.0, "referrals_from": ["W5", "W14", "W24", "W38", "W44"]},
        {"id": "W50", "initial_rank": 1.0, "referrals_from": ["W3", "W8", "W19", "W27", "W41"]}
      ]
    };
    
    setWebsiteData(networkData.websites);
  }, []);

  const calculatePageRank = () => {
    if (!websiteData) return;
    
    setLoading(true);
    
    setTimeout(() => {
      try {
        const n = websiteData.length;
        
        // Create adjacency matrix (represents links FROM column TO row)
        let M = Array(n).fill().map(() => Array(n).fill(0));
        
        // Map website IDs to indices for easier reference
        const idToIndex = {};
        websiteData.forEach((site, index) => {
          idToIndex[site.id] = index;
        });
        
        // Fill the adjacency matrix based on referrals
        // If W3 refers to W1, then M[0][2] = 1 (W1 index = 0, W3 index = 2)
        websiteData.forEach((site, i) => {
          site.referrals_from.forEach(referrer => {
            const j = idToIndex[referrer];
            M[i][j] = 1;
          });
        });
        
        // Calculate number of outbound links for each website
        const outDegrees = Array(n).fill(0);
        for (let j = 0; j < n; j++) {
          for (let i = 0; i < n; i++) {
            outDegrees[j] += M[i][j];
          }
        }
        
        // Modify the adjacency matrix to handle dangling nodes
        // If a website has no outgoing links, distribute evenly to all sites
        for (let j = 0; j < n; j++) {
          if (outDegrees[j] === 0) {
            for (let i = 0; i < n; i++) {
              M[i][j] = 1;
            }
            outDegrees[j] = n;
          }
        }
        
        // Normalize the columns to be stochastic
        for (let j = 0; j < n; j++) {
          for (let i = 0; i < n; i++) {
            M[i][j] = M[i][j] / outDegrees[j];
          }
        }
        
        // Initialize the rank vector with uniform distribution
        let rank = Array(n).fill(1/n);
        
        // PageRank power iteration
        let iter;
        for (iter = 0; iter < maxIterations; iter++) {
          // New rank vector
          const newRank = Array(n).fill((1 - dampingFactor) / n);
          
          // Apply transition matrix
          for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
              newRank[i] += dampingFactor * M[i][j] * rank[j];
            }
          }
          
          // Check convergence
          let diff = 0;
          for (let i = 0; i < n; i++) {
            diff += Math.abs(newRank[i] - rank[i]);
          }
          
          // Update rank vector
          rank = [...newRank];
          
          // Check if converged
          if (diff < tolerance) {
            break;
          }
        }
        
        // Normalize the rank vector if needed
        const sum = rank.reduce((a, b) => a + b, 0);
        if (Math.abs(sum - 1.0) > 1e-10) {
          rank = rank.map(r => r / sum);
        }
        
        // Create result objects
        const result = websiteData.map((website, i) => ({
          id: website.id,
          rank: rank[i]
        }));
        
        // Sort by rank (descending)
        result.sort((a, b) => b.rank - a.rank);
        
        setPageRankResults(result);
        setIterations(iter + 1);
        setLoading(false);
      } catch (error) {
        console.error('Error calculating PageRank:', error);
        setLoading(false);
      }
    }, 100);
  };

  const getChartData = () => {
    if (!pageRankResults) return [];
    
    return pageRankResults.map(item => ({
      websiteId: item.id,
      pageRank: item.rank
    }));
  };

  return (
    <div className="p-4 max-w-full">
      <h1 className="text-2xl font-bold mb-4">PageRank Algorithm Visualization</h1>
      
      <div className="mb-6 p-4 bg-gray-100 rounded-lg">
        <h2 className="text-lg font-semibold mb-3">Algorithm Parameters</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium mb-1">Damping Factor</label>
            <input
              type="number"
              min="0"
              max="1"
              step="0.01"
              value={dampingFactor}
              onChange={(e) => setDampingFactor(parseFloat(e.target.value))}
              className="p-2 border rounded w-full"
            />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Max Iterations</label>
            <input
              type="number"
              min="1"
              step="1"
              value={maxIterations}
              onChange={(e) => setMaxIterations(parseInt(e.target.value))}
              className="p-2 border rounded w-full"
            />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Convergence Tolerance</label>
            <input
              type="number"
              min="0.000001"
              max="0.1"
              step="0.000001"
              value={tolerance}
              onChange={(e) => setTolerance(parseFloat(e.target.value))}
              className="p-2 border rounded w-full"
            />
          </div>
        </div>
        <button
          onClick={calculatePageRank}
          disabled={loading || !websiteData}
          className="mt-4 bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded disabled:bg-gray-400"
        >
          {loading ? 'Calculating...' : 'Calculate PageRank'}
        </button>
      </div>
      
      {pageRankResults && (
        <div className="mt-6">
          <h2 className="text-lg font-semibold mb-3">PageRank Results (Iterations: {iterations})</h2>
          
          <div className="mb-6 h-96">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={getChartData().slice(0, 20)} margin={{ top: 20, right: 30, left: 20, bottom: 60 }}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="websiteId" angle={-45} textAnchor="end" />
                <YAxis />
                <Tooltip formatter={(value) => value.toFixed(6)} />
                <Legend />
                <Bar dataKey="pageRank" fill="#3b82f6" name="PageRank Value" />
              </BarChart>
            </ResponsiveContainer>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {pageRankResults.map((result, index) => (
              <div key={result.id} className="p-3 border rounded">
                <div className="font-medium">{index + 1}. {result.id}</div>
                <div className="text-gray-600">PageRank: {result.rank.toFixed(6)}</div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default PageRankVisualizer;

# Directed Acyclic Graph to String

This Haskell project implements a simple Directed Acyclic Graph (DAG) system. The project includes functionality for inserting edges into the graph, building the graph from a list of edges, finding the root nodes, converting the graph to a string representation, validating the graph as a DAG, and exporting the graph to the DOT format for visualization.

## Table of Contents

- [Introduction](#introduction)
- [Components](#components)
  - [Graph Representation](#graph-representation)
  - [Graph Operations](#graph-operations)
  - [DAG Validation](#dag-validation)
  - [Graph Visualization](#graph-visualization)
- [Usage](#usage)

## Introduction

The DAG Project is designed to help users create and manipulate Directed Acyclic Graphs (DAGs). It allows for operations such as adding edges, building the graph, checking for cycles, and converting the graph into a string or DOT format. This project demonstrates key Haskell concepts, including recursive functions, list operations, and higher-order functions.

## Components

### Graph Representation

- **Node**: A node in the graph is represented as a `String`.
- **Edge**: An edge is a pair of nodes, represented as `(Node, Node)`, where the first node is the parent, and the second node is the child.
- **Graph**: The graph is represented as a list of tuples, where each tuple contains a node and its list of children, i.e., `[(Node, [Node])]`.

### Graph Operations

- **insertEdge**: Adds an edge to the graph, updating the list of children for the corresponding parent node.
- **buildGraph**: Constructs a graph from a list of edges by repeatedly inserting each edge into the graph.
- **findRoot**: Identifies the root nodes of the graph, which are nodes with no incoming edges.
- **graph2str**: Converts a subgraph starting from a given node into a string representation.
- **children2str**: Converts a list of children into a string representation.
- **removeCommaAfterLastChild**: Removes the trailing comma from the string representation of the children.

### DAG Validation

- **isValidDAG**: Checks whether the graph is a valid DAG by detecting if any cycles are present in the graph using Depth-First Search (DFS).

### Graph Visualization

- **graphToDOT**: Converts the graph into the DOT format, which can be used with graph visualization tools like Graphviz.

## Usage

To use this project, follow these steps:

1. Ensure you have a Haskell compiler (e.g., GHC) installed on your system.
2. Clone or download this repository.
3. Navigate to the project directory in your terminal.
4. Compile the Haskell file using `ghc dag.hs`.
5. Run the executable `./dag` to start the application.
6. The program will:
   - Validate if the graph is a DAG.
   - Output the graph as a string starting from the root node.
   - Generate a DOT file (`graph.dot`) for visualization.
7. Use Graphviz or a similar tool to visualize the graph using the generated `graph.dot` file.


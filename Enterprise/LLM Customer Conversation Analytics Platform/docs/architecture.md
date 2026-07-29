# Architecture

## Component 1

SQL Server

Responsible for storing raw customer conversations.

---

## Component 2

Python Pipeline

Responsible for

- loading conversations
- prompt formatting
- batch inference

---

## Component 3

Fine-tuned Llama

Responsible for

- sentiment classification

- business category prediction

- structured output generation

---

## Component 4

Validation Layer

Responsible for

- output verification

- JSON validation

- duplicate checking

---

## Component 5

SQL Fact Tables

Stores

- conversation labels

- sentiment

- category

- AI metadata

---

## Component 6

Semantic Model

Responsible for

- reusable measures

- relationships

- business calculations

---

## Component 7

Power BI

Provides

- Executive Dashboard

- Trend Analysis

- Complaint Analytics

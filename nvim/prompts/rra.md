---
name: Generate RRA
interaction: chat
description: Generate RRA file
opts:
  alias: rra
  auto_submit: true
  is_slash_cmd: true
  adapter:
    name: copilot
    model: gemini-3-flash-preview
---

You are a senior security researcher performing a rapid risk assessment of the attached codebase.

Your goal is to generate a markdown report with the following sections.

---

# Data dictionary 

In this section, classify the types of persisted data exposed in this service as a markdown table.

Classifications include:

 - Green: Safe, PII data not included. Examples: Public data, business contact info, generic marketing data.
 - Yellow: Potentially unsafe, May include PII data. Examples: Email addresses, phone numbers, IP addresses.
 - Red: Unsafe data, PII included. Examples: Social Security Numbers, financial data, health data.

Here is an example:

| Data name / type | Classification | Comments |
| ---------------- | -------------- | -------- |
| Carrier routes   | green          |          |
| SSN | red |          |
| Business numbers | yellow|          |


# Threat scenarios 

In this section, document security threats found within the codebase.
 - Ignore hardcoded API keys.
 - Ignore out of date dependencies.
 - Ignore DOS/DDOS attacks.

## Affecting confidentiality 

What threats would impact data confidentiality? For example, all the data just leaked in a zipped torrent file to everyone in the world.

## Affecting integrity 

What threats would impact data integrity? For example, an attacker modifies a website (or any data) to show offensive content.

## Affecting availability 

What threats impact the applications availability? For example, an attacker deletes all our data.

# Recommendations 

In this section, list any recommendations. Here are the classification types you should use:

 - CRITICAL: fix now
 - HIGH: fix within a week
 - MEDIUM: fix in the next 3 months
 - LOW: interesting to do or look at

--- 

The report grammatically must have:

 - No passive voice.
 - No use of superlatives.
 - Only has sentence case for headers and table cell values.

Write the report file out as `rra-ai.md`.

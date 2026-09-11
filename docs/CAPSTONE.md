# Capstone Specification — The Invisible Network

## Title

**The Invisible Network: Catching a laundering ring that every individual alert missed**

## Governing concept

The capstone is an adversarial AML detection challenge, not a generic analytics pipeline.

A synthetic laundering network will be deliberately engineered so that each individual account appears unremarkable under conventional rule-based monitoring. Transactions are designed to remain below obvious thresholds and avoid simple single-account alerts.

The project must demonstrate the contrast between what a rules-only system misses and what network-aware analytics can reveal.

## Headline reveal

The final headline must be calculated from the actual experiment, not predetermined. The intended form is:

> **N accounts. 0 individual alerts. 1 coordinated laundering network.**

All figures reported in the final project must be produced by the dataset and analysis.

## Required analytical layers

1. **Author the synthetic ground truth**
   - define mule accounts, shell entities, legitimate controls and final beneficiaries
   - plant structuring, rapid movement, layering, circular flows and linked-entity behaviour
   - preserve known ground truth for objective evaluation

2. **Rules-only baseline**
   - implement conventional SQL transaction-monitoring rules
   - measure which suspicious entities/transactions are detected or missed
   - record alert volume and false positives

3. **Graph/network detection**
   - use Python and NetworkX to model relationships between accounts, entities, devices and beneficiaries
   - detect connected components, circular paths, consolidation/dispersal patterns and hidden relationships
   - demonstrate the network that individual account rules failed to expose

4. **Anomaly / challenger analytics**
   - add behavioural or anomaly-based detection where it provides measurable value
   - compare challenger performance with the rules-only baseline

5. **Measured comparison**
   - detection rate / recall
   - precision where appropriate
   - false-positive rate
   - alert volume
   - missed-network rate
   - measurable lift from additional analytical layers

6. **Investigation**
   - reconstruct the movement of funds
   - identify the suspicious typology and supporting evidence
   - distinguish evidence from inference
   - document the analyst decision and escalation rationale

7. **Model challenge / defence**
   - identify false positives and failure modes
   - challenge assumptions and data quality
   - assess bias and explainability risks where relevant
   - identify what a validator, investigator or legal challenge could question
   - state what evidence is insufficient for deployment or conclusion
   - define where human review remains necessary

8. **Irish AML application**
   - conclude with an FIU Ireland-style STR case narrative based on the detected network
   - keep the narrative evidence-based and consistent with the Irish/EU AML context

## Portfolio objective

The capstone should demonstrate that the analyst can do more than detect an unusual transaction. It should show the ability to:

**design an adversarial scenario → establish a baseline → expose a hidden network → quantify analytical lift → investigate the case → challenge the detection approach → communicate the case in an Irish AML context.**

## Locked rule

This capstone specification is part of the governed programme scope. It should not be replaced by a generic AML dataset-analysis project unless explicitly reopened.

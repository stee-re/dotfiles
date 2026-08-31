# IED, Substation/Process and DataTypeTemplates/NSD

## IED

| Export | Kind | Description |
|---|---|---|
| `insertIed` | function | Inserts an IED from an ICD/CID |
| `updateIED` | function | Updates IED attributes |
| `removeIED` | function | Removes an IED and cleans up references |

## Substation / Process

| Export | Kind | Description |
|---|---|---|
| `updateSubstation` | function | Updates Substation attributes |
| `updateVoltageLevel` | function | Updates VoltageLevel attributes |
| `updateBay` | function | Updates Bay attributes |
| `removeProcessElement` | function | Removes a process structure element |

## DataTypeTemplates / NSD

| Export | Kind | Description |
|---|---|---|
| `nsdToJson` | function | Parses NSD XML to JSON structure |
| `insertSelectedLNodeType` | function | Inserts an LNodeType from selection |
| `removeDataType` | function | Removes a data type template element |
| `importLNodeType` | function | Imports an LNodeType from another document |
| `updateLNodeType` | function | Updates LNodeType attributes |
| `lNodeTypeToSelection` | function | Converts LNodeType to tree selection |

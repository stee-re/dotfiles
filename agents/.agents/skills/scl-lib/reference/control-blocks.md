# Control Blocks, DataSet, FCDA and Communication

## Control Blocks

| Export | Kind | Description |
|---|---|---|
| `createGSEControl` | function | Creates a GSEControl with associated DataSet and GSE |
| `updateGSEControl` | function | Updates GSEControl attributes |
| `createSampledValueControl` | function | Creates SampledValueControl with associated DataSet and SMV |
| `updateSampledValueControl` | function | Updates SampledValueControl attributes |
| `createReportControl` | function | Creates a ReportControl with associated DataSet |
| `updateReportControl` | function | Updates ReportControl attributes |
| `removeControlBlock` | function | Removes a control block element |
| `findControlBlockSubscription` | function | Finds subscriptions for a control block |
| `controlBlockObjRef` | function | `(element: Element) => string \| null` — builds object reference string |
| `controlBlockGseOrSmv` | function | Finds associated GSE/SMV communication element |

## DataSet

| Export | Kind | Description |
|---|---|---|
| `createDataSet` | function | Creates a DataSet element |
| `removeDataSet` | function | Removes a DataSet element |
| `updateDataSet` | function | Updates DataSet attributes |
| `CreateDataSetOptions` | type | Options for createDataSet |

## FCDA

| Export | Kind | Description |
|---|---|---|
| `removeFCDA` | function | Removes an FCDA element |
| `canAddFCDA` | function | Checks if FCDA can be added |
| `maxAttributes` | function | Max attributes for FCDA |
| `fcdaBaseTypes` | function | Base types for FCDA |

## Communication (GSE/SMV addresses)

| Export | Kind | Description |
|---|---|---|
| `createGSE` | function | Creates a GSE communication element |
| `changeGSEContent` | function | Updates GSE address content |
| `createSMV` | function | Creates an SMV communication element |
| `changeSMVContent` | function | Updates SMV address content |

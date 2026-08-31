# Subscription (ExtRef) and Supervision

## Subscription (ExtRef)

| Export | Kind | Description |
|---|---|---|
| `subscribe` | function | Creates subscription (ExtRef) edits |
| `unsubscribe` | function | Creates unsubscription edits |
| `matchDataAttributes` | function | Matches FCDA data attributes to ExtRef |
| `matchSrcAttributes` | function | Matches source control block attributes |
| `extRefTypeRestrictions` | function | Gets type restrictions for ExtRef |
| `doesFcdaMeetExtRefRestrictions` | function | Checks FCDA compatibility |
| `sourceControlBlock` | function | Finds the source control block for an ExtRef |
| `isSubscribed` | function | Checks if an ExtRef is subscribed |

## Supervision

| Export | Kind | Description |
|---|---|---|
| `canInstantiateSubscriptionSupervision` | function | Checks if supervision LN can be added |
| `instantiateSubscriptionSupervision` | function | Creates supervision LN edits |
| `insertSubscriptionSupervisions` | function | Inserts supervision LNs |
| `removeSupervision` | function | Removes a supervision LN |

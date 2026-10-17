# Plugin inventory

Pure discovery inventory: which plugins exist, where. **No verdicts here** —
compliance results belong in `audit-report.md`. Populated/maintained by the
plugin-discovery job (`job-plugin-discovery.md`); consumed by the audit job.

| Repo | Plugin name | Location | Source kind |
|---|---|---|---|
| com-pas/compas-open-scd | CompasVersions | src/compas-editors/CompasVersions.js | local file |
| com-pas/compas-open-scd | Sitipe | src/compas-editors/Sitipe.js | local file |
| com-pas/compas-open-scd | AutogenSubstation | src/compas-editors/autogen-substation.js | local file |
| com-pas/compas-open-scd | CompasValidateSchema | src/validators/CompasValidateSchema.js | local file |
| com-pas/compas-open-scd | CompasOpen | src/menu/CompasOpen.js | local file |
| com-pas/compas-open-scd | CompasCimMapping | src/menu/CompasCimMapping.js | local file |
| com-pas/compas-open-scd | CompasImportFromApi | src/menu/CompasImportFromApi.js | local file |
| com-pas/compas-open-scd | CompasSave | src/menu/CompasSave.js | local file |
| com-pas/compas-open-scd | CompasSaveAs | src/menu/CompasSaveAs.js | local file |
| com-pas/compas-open-scd | CompasSaveAsVersion | src/menu/CompasSaveAsVersion.js | local file |
| com-pas/compas-open-scd | CompasImportIEDs | src/menu/CompasImportIEDs.js | local file |
| com-pas/compas-open-scd | CompasMerge | src/menu/CompasMerge.js | local file |
| com-pas/compas-open-scd | CompasUpdateSubstation | src/menu/CompasUpdateSubstation.js | local file |
| com-pas/compas-open-scd | CompasCompareIED | src/menu/CompasCompareIED.js | local file |
| com-pas/compas-open-scd | CompasAutoAlignment | src/menu/CompasAutoAlignment.js | local file |
| com-pas/compas-open-scd | ExportIEDParams | src/menu/ExportIEDParams.js | local file |
| com-pas/compas-open-scd | LocamationVMU | src/menu/LocamationVMU.js | local file |
| com-pas/compas-open-scd | CompasSettings | src/menu/CompasSettings.js | local file |
| com-pas/compas-open-scd | Substation | @compas-oscd/plugins dist/editors/Substation.js | npm package |
| com-pas/compas-open-scd | SingleLineDiagram | @compas-oscd/plugins dist/editors/SingleLineDiagram.js | npm package |
| com-pas/compas-open-scd | GooseSubscriberMessageBinding | @compas-oscd/plugins dist/editors/GooseSubscriberMessageBinding.js | npm package |
| com-pas/compas-open-scd | GooseSubscriberDataBinding | @compas-oscd/plugins dist/editors/GooseSubscriberDataBinding.js | npm package |
| com-pas/compas-open-scd | SMVSubscriberMessageBinding | @compas-oscd/plugins dist/editors/SMVSubscriberMessageBinding.js | npm package |
| com-pas/compas-open-scd | SMVSubscriberDataBinding | @compas-oscd/plugins dist/editors/SMVSubscriberDataBinding.js | npm package |
| com-pas/compas-open-scd | Communication | @compas-oscd/plugins dist/editors/Communication.js | npm package |
| com-pas/compas-open-scd | Protocol104 | @compas-oscd/plugins dist/editors/Protocol104.js | npm package |
| com-pas/compas-open-scd | Templates | @compas-oscd/plugins dist/editors/Templates.js | npm package |
| com-pas/compas-open-scd | Cleanup | @compas-oscd/plugins dist/editors/Cleanup.js | npm package |
| com-pas/compas-open-scd | ValidateSchema | @compas-oscd/plugins dist/validators/ValidateSchema.js | npm package |
| com-pas/compas-open-scd | ValidateTemplates | @compas-oscd/plugins dist/validators/ValidateTemplates.js | npm package |
| com-pas/compas-open-scd | NewProject | @compas-oscd/plugins dist/menu/NewProject.js | npm package |
| com-pas/compas-open-scd | VirtualTemplateIED | @compas-oscd/plugins dist/menu/VirtualTemplateIED.js | npm package |
| com-pas/compas-open-scd | SubscriberInfo | @compas-oscd/plugins dist/menu/SubscriberInfo.js | npm package |
| com-pas/compas-open-scd | UpdateDescriptionABB | @compas-oscd/plugins dist/menu/UpdateDescriptionABB.js | npm package |
| com-pas/compas-open-scd | UpdateDescriptionSEL | @compas-oscd/plugins dist/menu/UpdateDescriptionSEL.js | npm package |
| com-pas/compas-open-scd | SclHistory | @compas-oscd/plugins dist/menu/SclHistory.js | npm package |
| com-pas/compas-open-scd | Help | @compas-oscd/plugins dist/menu/Help.js | npm package |
| com-pas/compas-open-scd | ExportCommunication | @compas-oscd/plugins dist/menu/ExportCommunication.js | npm package |
| com-pas/compas-open-scd | IED | /external-plugins/IedEditor.js | external URL |
| com-pas/compas-open-scd | Publisher | /external-plugins/oscd-publisher/oscd-publisher.js | git submodule (checked out) |
| com-pas/compas-open-scd | Communication Explorer | /external-plugins/oscd-plugins/communication-explorer/0.0.32/index.js | git submodule (checked out) |
| com-pas/compas-open-scd | Template Generator | /external-plugins/oscd-template-generator/oscd-template-generator.js | git submodule (checked out) |
| com-pas/compas-open-scd | Subscribe (Later Binding) | /external-plugins/oscd-subscriber-later-binding/oscd-subscriber-later-binding.js | git submodule (checked out) |
| com-pas/compas-open-scd | Template Update | /external-plugins/scl-template-update/scl-template-update.js | git submodule (checked out) |
| com-pas/compas-open-scd | Bay Template | /external-plugins/scl-bay-template/scl-bay-template.js | git submodule (checked out) |
| com-pas/compas-open-scd | Bay Template Editor | /external-plugins/oscd-bay-template-editor/bay-template-editor.js | git submodule (checked out) |
| com-pas/compas-open-scd | Extract IED | /external-plugins/mbg-ied-extractor/mbg-icd-extractor.js | git submodule (checked out) |
| com-pas/compas-open-scd | Wizarding | /external-plugins/scl-wizarding/scl-wizarding.js | git submodule (checked out) |
| com-pas/compas-open-scd | Plugins Hub | /external-plugins/compas-bearingpoint-plugins/plugins/plugins-hub/index.js | external URL |
| com-pas/compas-open-scd | Engineering Wizard | /external-plugins/compas-transnetbw-plugins/plugins/engineering-wizard/index.js | external URL |
| com-pas/compas-open-scd | Template Generator (TransnetBW) | /external-plugins/compas-transnetbw-plugins/plugins/template-generator/index.js | external URL |
| com-pas/compas-open-scd | Location Manager | /external-plugins/compas-transnetbw-plugins/plugins/location-manager/index.js | external URL |
| com-pas/compas-open-scd | Location Viewer | /external-plugins/compas-transnetbw-plugins/plugins/location-viewer/index.js | external URL |
| com-pas/compas-open-scd | History Viewer | /external-plugins/compas-transnetbw-plugins/plugins/history-viewer/index.js | external URL |
| com-pas/compas-open-scd | Archive Explorer | /external-plugins/compas-transnetbw-plugins/plugins/archive-explorer/index.js | external URL |
| open-scd | Type Distributor | https://sprinteins.github.io/oscd-plugins/type-distributor/index.js | external URL |
| open-scd | Type Designer | https://sprinteins.github.io/oscd-plugins/type-designer/index.js | external URL |
| open-scd | Auto Doc | https://sprinteins.github.io/oscd-plugins/auto-doc/index.js | external URL |
| open-scd | I/O Center | https://sprinteins.github.io/oscd-plugins/io-center/index.js | external URL |
| open-scd | IED | plugins/src/editors/IED.js | local file |
| open-scd | Communication Explorer | https://sprinteins.github.io/oscd-plugins/communication-explorer/index.js | external URL |
| open-scd | Network Explorer | https://sprinteins.github.io/oscd-plugins/network-explorer/index.js | external URL |
| open-scd | Type Switcher | https://sprinteins.github.io/oscd-plugins/type-switcher/index.js | external URL |
| open-scd | Documentation | https://sprinteins.github.io/oscd-plugins/documentation/index.js | external URL |
| open-scd | Template Generator | https://sprinteins.github.io/oscd-template-generator/oscd-template-generator.js | external URL |
| open-scd | Substation | plugins/src/editors/Substation.js | local file |
| open-scd | Single Line Diagram | plugins/src/editors/SingleLineDiagram.js | local file |
| open-scd | Subscriber Message Binding (GOOSE) | plugins/src/editors/GooseSubscriberMessageBinding.js | local file |
| open-scd | Subscriber Data Binding (GOOSE) | plugins/src/editors/GooseSubscriberDataBinding.js | local file |
| open-scd | Subscriber Message Binding (SMV) | plugins/src/editors/SMVSubscriberMessageBinding.js | local file |
| open-scd | Subscriber Data Binding (SMV) | plugins/src/editors/SMVSubscriberDataBinding.js | local file |
| open-scd | Subscriber Later Binding (SMV/GOOSE) | external-plugins/oscd-subscriber-later-binding/oscd-subscriber-later-binding.js | local file |
| open-scd | Communication | plugins/src/editors/Communication.js | local file |
| open-scd | 104 | plugins/src/editors/Protocol104.js | local file |
| open-scd | Templates | plugins/src/editors/Templates.js | local file |
| open-scd | Publisher | external-plugins/oscd-publisher/oscd-publisher.js | local file |
| open-scd | Cleanup | plugins/src/editors/Cleanup.js | local file |
| open-scd | Validate Schema | plugins/src/validators/ValidateSchema.js | local file |
| open-scd | Validate Templates | plugins/src/validators/ValidateTemplates.js | local file |
| open-scd | Open project | plugins/src/menu/OpenProject.js | local file |
| open-scd | New project | plugins/src/menu/NewProject.js | local file |
| open-scd | Plugin Store (Beta) | https://sprinteins.github.io/oscd-plugin-store/index.js | external URL |
| open-scd | Save project | plugins/src/menu/SaveProject.js | local file |
| open-scd | Import IEDs | plugins/src/menu/ImportIEDs.js | local file |
| open-scd | Create Virtual IED | plugins/src/menu/VirtualTemplateIED.js | local file |
| open-scd | Subscriber Update | plugins/src/menu/SubscriberInfo.js | local file |
| open-scd | Update desc (ABB) | plugins/src/menu/UpdateDescriptionABB.js | local file |
| open-scd | Update desc (SEL) | plugins/src/menu/UpdateDescriptionSEL.js | local file |
| open-scd | Merge Project | plugins/src/menu/Merge.js | local file |
| open-scd | Update Substation | plugins/src/menu/UpdateSubstation.js | local file |
| open-scd | Compare IED | plugins/src/menu/CompareIED.js | local file |
| open-scd | Show SCL History | plugins/src/menu/SclHistory.js | local file |
| open-scd | Help | plugins/src/menu/Help.js | local file |
| open-scd | Export Communication Section | plugins/src/menu/ExportCommunication.js | local file |
| open-scd | Plugin Store | https://sprinteins.github.io/oscd-plugin-store/index.js | external URL |

Source kind values: `local file` / `npm package` / `git submodule (not
checked out)` / `git submodule (checked out)` / `external URL`.

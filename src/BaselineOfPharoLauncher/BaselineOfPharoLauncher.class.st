Class {
	#name : #BaselineOfPharoLauncher,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoLauncher
}

{ #category : #baselines }
BaselineOfPharoLauncher >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: #Ston
				with: [ spec repository: 'github://svenvc/ston:master/repository' ];
			baseline: #Spec2
				with: [ spec repository: 'github://pharo-spec/Spec:spec-pharo-launcher/src' ];
			baseline: #OSSubprocess
				with: [ spec repository: 'github://pharo-contributions/OSSubprocess:v1.2' ];
			baseline: #OSWinSubprocess
				with: [ spec repository: 'github://pharo-contributions/OSWinSubprocess:v1' ];
			baseline: #XMLParser
				with: [ spec 
							repository: 'github://pharo-contributions/XML-XMLParser:3.5.x';
							loads: #('Core') ].
		spec
			package: #'PharoLauncher-80Compatibility'; 
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'XMLParser' #'OSSubprocess' #'OSWinSubprocess' #'Ston' #'PharoLauncher-80Compatibility'). ];
			package: #'PharoLauncher-Spec2' with: [ 
				spec requires: #(#'PharoLauncher-Core' #Spec2). ];

			package: #'PharoLauncher-Tests-Commands' with: [
				spec requires: #(#'PharoLauncher-Spec2' ). ].
		spec 
			group: 'Default' with: #(#'PharoLauncher-Core' #'PharoLauncher-Spec2' #'PharoLauncher-Tests-Commands'). ].
]

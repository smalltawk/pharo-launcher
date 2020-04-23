Class {
	#name : #PhLLaunchImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir',
		'process'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLLaunchImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new.
	imageDir := FileLocator temp / 'pharo-launcher-tests-launch-image-command' , UUIDGenerator next asString.
	imageDir ensureCreateDirectory
]

{ #category : #running }
PhLLaunchImageCommandTest >> tearDown [ 
	imageDir ensureDeleteAll.
	self traceCr: 'in tearDown'.
	self traceCr: 'process: ' , process asString.
	self traceCr: 'process is Running? ' , process isRunning asString.
	process ifNotNil: [ process isRunning ifTrue: [ process terminate ] ].
	self traceCr: 'process terminated'
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImage [
	| command image |
	self traceCr: 'Running phLLaunchImageCommandTest>>#testcanLaunchImage'.
	command := PhLLaunchImageCommand new.
	command context: presenter.
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
	presenter selection: image.

	self traceCr: 'will run the process'.
	process := command execute.
	self traceCr: 'pid: ', (process instVarNamed: 'process') pid asString.
	self traceCr: 'process running? ', process isRunning asString.
	"self traceCr: process pid asString."
	self traceCr: 'start waiting ' , DateAndTime now asString.
	2 seconds wait. "let time to the image to be opened by the VM"
	self traceCr: 'stop waiting ' , DateAndTime now asString.
	self traceCr: 'process running? ', process isRunning asString.
	self traceCr: 'process isSuccess? ', process isSuccess asString.
	self traceCr: 'process stederr: ', process stderrString.
	self assert: process isRunning.
	self traceCr: 'end of test'.
]

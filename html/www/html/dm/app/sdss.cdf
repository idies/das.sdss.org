CDIF,SYNTAX "SYNTAX.1" "01.00.00",ENCODING "ENCODING.1" "01.00.00"
(HEADER
  (USES
    (CHARACTERSET PrintableASCII)
    (TEXTFORMAT Unformatted)
  )
  (SUMMARY
    (ExporterName "Paradigm Plus")
    (ExporterVersion "02.00.00")
    (ExporterDate "1995/11/17")
    (ExporterTime "14:1:19")
  )
)
(META-MODEL
  (CDIFVERSION "01.00.00")
  #|(SCHEMA rumbaugh.pgm)|#
)
(MODEL
  (Diagram "Administration"
    (Name "Administration")
    (Document "sdss02.dgm")
    (Type "Object Diagram")
  )

  (Diagram "Imaging"
    (Name "Imaging")
    (Document "sdss01.dgm")
    (Type "Object Diagram")
  )

  (Diagram "MT"
    (Name "MT")
    (Document "sdss04.dgm")
    (Type "Object Diagram")
  )

  (Diagram "Object Flags"
    (Name "Object Flags")
    (Document "sdss06.dgm")
    (Type "State Diagram")
  )

  (Diagram "Object State Diagram"
    (Name "Object State Diagram")
    (Document "sdss07.dgm")
    (Type "State Diagram")
  )

  (Diagram "SurveyStrategy"
    (Name "SurveyStrategy")
    (Document "sdss03.dgm")
    (Type "Object Diagram")
  )

  (Diagram "Target Selection"
    (Name "Target Selection")
    (Document "sdss05.dgm")
    (Type "Data Flow Diagram")
  )

  (Diagram "TargetSelection"
    (Name "TargetSelection")
    (Document "sdss08.dgm")
    (Type "Data Flow Diagram")
  )

  (Script "Draw Relationships"
    (Name "Draw Relationships")
    (Document "drawrel.scr")
  )

  (Script "Reorder Attributes"
    (Name "Reorder Attributes")
    (Document "reorderAttr.scr")
  )

  (Script "test script"
    (Name "test script")
    (Document "test.scr")
  )

  (Class "Action"
    (Name "Action")
    (Class "arAction")
    (Source "adminSch")
    (Description "An action is any sort of activity performed in the course of the survey whose execution must be recorded.")
    (Persistence "PERSISTENT")
  )

  (Class "Astrometric Calibration"
    (Name "Astrometric Calibration")
    (Class "arAstromCalib")
    (Source "photoSch")
    (Description "Contains the results of one run of the astrometric pipeline.")
    (Division "ACTIVE")
    (Concurrency "ACTIVE")
    (Persistence "PERSISTENT")
  )

  (Class "Astrometric Pipeline Plan"
    (Name "Astrometric Pipeline Plan")
    (Class "arAstromPipePlan")
    (Document "asPlan.html")
    (Source "photoSch")
    (Description "A plan for one run of the astrometric pipeline.")
    (Division "TERMINATOR")
    (Persistence "PERSISTENT")
  )

  (Class "Astrometric Transformation"
    (Name "Astrometric Transformation")
    (Class "arTrans")
    (Document "asTrans.html")
    (Source "photoSch")
    (Description "An astrometric transformation from frame coordinates to great circle coordinates.")
    (Concurrency "BLOCKING")
    (Metaclass "TRUE")
    (Utility "TRUE")
  )

  (Class "Atlas Image"
    (Name "Atlas Image")
    (Class "arAtlasImage")
    (Document "fpAtlas.html")
    (Source "photoSch")
    (Description "A subsection of an image containing a detected object.")
    (Cardinality "1")
    (Persistence "PERSISTENT")
  )

  (Class "Bias Vector"
    (Name "Bias Vector")
    (Document "psB.html")
    (Source "photoSch")
    (Division "ACTIVE")
    (Persistence "PERSISTENT")
  )

  (Class "Binned Noise Frame"
    (Name "Binned Noise Frame")
    (Document "fpBIN.html")
    (Source "photoSch")
    (Description "4x4 binned noise image.")
    (Division "ACTIVE")
    (Persistence "PERSISTENT")
    (Utility "TRUE")
  )

  (Class "Calibrated Magnitude"
    (Name "Calibrated Magnitude")
    (Description "A calibrated magnitude.")
    (Derived "TRUE")
  )

  (Class "Calibrated Patch"
    (Name "Calibrated Patch")
    (Description "List of astrometrically and photometrically calibrated stars in a single calibration patch.")
    (Derived "TRUE")
  )

  (Class "Calibrated Secondary Star"
    (Name "Calibrated Secondary Star")
    (Class "arCalibSecStar")
    (Description "A secondary photometric standard star, astrometrically and photometrically calibrated.")
    (Derived "TRUE")
  )

  (Class "Calibration Coefficient"
    (Name "Calibration Coefficient")
    (Derived "TRUE")
  )

  (Class "Calibration Patch"
    (Name "Calibration Patch")
    (Class "arCalibPatch")
    (Source "strategySch")
    (Description "A piece of the sky observed by the MT in order to calibrate secondary photometric standard stars.")
  )

  (Class "CCD Calibration"
    (Name "CCD Calibration")
    (Class "arCCDCalibration")
    (Source "basicSch")
    (Type "ABSTRACT")
  )

  (Class "Corrected Frame"
    (Name "Corrected Frame")
    (Document "fpC.html")
    (Source "photoSch")
    (Division "ACTIVE")
    (Utility "TRUE")
  )

  (Class "DA Star"
    (Name "DA Star")
    (Class "arDAStar")
    (Document "idGang.html")
    (Source "photoSch")
    (Description "A star detected on the photometric bright star finder in the Imaging Camera Data Acquisition System.")
    (Cardinality "1")
    (Concurrency "BLOCKING")
  )

  (Class "Detection"
    (Name "Detection")
    (Class "arDetection.html")
    (Source "photoSch")
    (Persistence "PERSISTENT")
  )

  (Class "Double Precision Measurement"
    (Name "Double Precision Measurement")
    (Class "arDoubleErr")
    (Source "basicSch")
    (Description "A double precision floating point value with an associated single precision floating point variance.")
  )

  (Class "Equatorial Coordinate"
    (Name "Equatorial Coordinate")
    (Source "basicSch")
    (Description "An astronomical equaotiral coordinate.")
  )

  (Class "Excalibur Plan"
    (Name "Excalibur Plan")
    (Class "arExcaliburPlan")
    (Document "exPlan.html")
    (Source "mtSch")
    (Description "A processing plan for a single run of Excalibur.  Each plan targets a list of star lists output by the MT Pipeline.")
    (Persistence "PERSISTENT")
  )

  (Class "Excalibur Run"
    (Name "Excalibur Run")
    (Class "arMTExcaliburRun")
    (Persistence "PERSISTENT")
  )

  (Class "Exposure"
    (Name "Exposure")
    (Class "arExposure")
    (Source "basicSch")
    (Description "A single exposure with a point-and-shoot CCD camera.  It may have more than one CCD.")
    (Persistence "PERSISTENT")
  )

  (Class "Field"
    (Name "Field")
    (Source "photoSch")
    (Description "Set of frames within a drift scan run which point at the same piece of sky.")
    (Persistence "PERSISTENT")
  )

  (Class "Flat Field Vector"
    (Name "Flat Field Vector")
    (Document "psFF.html")
    (Source "photoSch")
    (Division "ACTIVE")
    (Persistence "PERSISTENT")
  )

  (Class "Frame"
    (Name "Frame")
    (Source "photoSch")
    (Description "A single exposure with a CCD on the imaging camera.")
  )

  (Class "Frame Parameters"
    (Name "Frame Parameters")
    (Document "mtObj.html")
    (Metaclass "TRUE")
  )

  (Class "Frame Statistic"
    (Name "Frame Statistic")
    (Class "arFrameStat")
    (Document "fpFieldStat.html")
    (Source "photoSch")
    (Description "Summary statistics for the output of the frames pipeline on a single frame.")
    (Persistence "PERSISTENT")
    (Metaclass "TRUE")
    (Utility "TRUE")
  )

  (Class "Frames Pipeline Plan"
    (Name "Frames Pipeline Plan")
    (Class "arFramesPlan")
    (Document "fpPlan.html")
    (Source "photoSch")
    (Division "TERMINATOR")
    (Persistence "PERSISTENT")
  )

  (Class "Frames Pipeline Run"
    (Name "Frames Pipeline Run")
    (Class "arFramesPipeRun")
    (Document "framesPipeRun.html")
    (Persistence "PERSISTENT")
  )

  (Class "Image Pipeline Plan"
    (Name "Image Pipeline Plan")
    (Persistence "PERSISTENT")
  )

  (Class "Image Pipeline Run"
    (Name "Image Pipeline Run")
    (Class "arImagePipeRun")
    (Source "photoSch")
    (Description "A combined run of the SSC, astrometric, postage stamp, and frames pipelines, processing the data from a single imaging run.")
    (Persistence "PERSISTENT")
  )

  (Class "Imaging Run"
    (Name "Imaging Run")
    (Class "arRun")
    (Document "idReport.html")
    (Source "photoSch")
    (Description "A single drift scan with the imaging camera.")
    (Division "SUBSYSTEM")
    (Persistence "PERSISTENT")
  )

  (Class "Known Magnitude"
    (Name "Known Magnitude")
    (Description "A known magnitude.")
    (Persistence "PERSISTENT")
  )

  (Class "Medium Object Detection"
    (Name "Medium Object Detection")
    (Class "arMediumObject")
    (Document "fpObjc.html")
    (Source "photoSch")
    (Cardinality "1")
    (Persistence "PERSISTENT")
  )

  (Class "Merge Run"
    (Name "Merge Run")
    (Description "The results of merging objects from one frames pipeline run with other objects in the database.")
    (Persistence "PERSISTENT")
  )

  (Class "MT Calibration"
    (Name "MT Calibration")
    (Document "mtPhotom.html")
    (Metaclass "TRUE")
  )

  (Class "MT Detection"
    (Name "MT Detection")
    (Class "arMTDetection")
    (Description "A single detection of a star on a MT exposure.")
    (Persistence "PERSISTENT")
  )

  (Class "MT Exposure"
    (Name "MT Exposure")
    (Source "mtSch")
    (Description "A single exposure with the MT.")
  )

  (Class "MT Pipeline Plan"
    (Name "MT Pipeline Plan")
    (Class "mtPipePlan")
    (Document "mtPlan.html")
    (Source "mtSch")
    (Description "A processing plan for the MT pipeline.  Each plan targets a list of MT sequences.")
    (Division "TERMINATOR")
    (Persistence "PERSISTENT")
  )

  (Class "MT Sequence"
    (Name "MT Sequence")
    (Class "arMTSequence")
    (Source "mtSch")
    (Description "A sequence ofcontiguous exposures with the MT of the same target, spanning all relevant filters.")
  )

  (Class "MT Star"
    (Name "MT Star")
    (Class "arMTStar")
    (Document "mtObj.html")
    (Source "mtSch")
    (Description "A single star detected within an MT sequence.")
    (Persistence "PERSISTENT")
    (Metaclass "TRUE")
  )

  (Class "MT Star List"
    (Name "MT Star List")
    (Class "arMTStarList")
    (Source "mtSch")
    (Description "List of all stars detected within a single MT sequence.")
    (Persistence "PERSISTENT")
  )

  (Class "MT Target"
    (Name "MT Target")
    (Class "arMTTarget")
    (Source "strategySch")
    (Description "A target for observation with the MT.")
    (Type "ABSTRACT")
    (Persistence "PERSISTENT")
  )

  (Class "Object"
    (Name "Object")
    (Class "arObject")
    (Source "photoSch")
    (Container "photoSch")
    (Description "A single detected object within a field.")
    (Persistence "PERSISTENT")
  )

  (Class "Object List"
    (Name "Object List")
    (Class "arFieldStat")
    (Source "photoSch")
    (Description "Statistics summarizing the results of the frames pipeline on this frame.")
    (Persistence "PERSISTENT")
    (Utility "TRUE")
  )

  (Class "Object Parameter Value "
    (Name "Object Parameter Value ")
    (Class "arObjParamValue")
    (Source "adminSch")
    (Description "A value for an object parameter.")
    (Persistence "PERSISTENT")
  )

  (Class "Parameter  "
    (Name "Parameter  ")
    (Class "arParameter")
    (Source "adminSch")
    (Description "A parameter to a task.  This doesn't store the value of the parameter, merely its name and a description.")
    (Persistence "PERSISTENT")
  )

  (Class "Parameter Value"
    (Name "Parameter Value")
    (Class "arParamValue")
    (Source "adminSch")
    (Description "A instance value for a <<arParameter>> (i.e., each instance of this class assigns a value to an instance of <<arParameter>>).")
    (Type "ABSTRACT")
    (Persistence "PERSISTENT")
  )

  (Class "Person "
    (Name "Person ")
    (Class "arPerson")
    (Source "adminSch")
    (Description "A person.  This is not meant to be a personnel file, rather merely a target to which we may point to record who did what.")
    (Persistence "PERSISTENT")
  )

  (Class "Photometric Calibration"
    (Name "Photometric Calibration")
    (Class "_coeef")
    (Persistence "PERSISTENT")
  )

  (Class "Photometric Transformation"
    (Name "Photometric Transformation")
    (Class "arPhotoTrans")
    (Document "psCB.html")
    (Source "photoSch")
    (Description "A photometric transformation for a single frame, as derived by the PS Pipeline.")
    (Utility "TRUE")
  )

  (Class "Plan"
    (Name "Plan")
    (Class "arPlan")
    (Source "adminSch")
    (Persistence "PERSISTENT")
  )

  (Class "Plan Entry"
    (Name "Plan Entry")
    (Class "arPlanEntry")
    (Source "adminSch")
    (Description "A plan entry is a base class for planning a single survey activity.")
    (Type "ABSTRACT")
    (Persistence "PERSISTENT")
  )

  (Class "Postage Stamp"
    (Name "Postage Stamp")
    (Document "scFang.html")
    (Source "photoSch")
    (Description "Small (29x29) subimages cut out by the Data Acquisition System around a detected or suspected star.")
    (Concurrency "BLOCKING")
    (Persistence "PERSISTENT")
  )

  (Class "Postage Stamp Calibration"
    (Name "Postage Stamp Calibration")
    (Class "arPSCalib")
    (Source "photoSch")
    (Persistence "PERSISTENT")
  )

  (Class "Postage Stamp Pipeline Plan"
    (Name "Postage Stamp Pipeline Plan")
    (Class "arPSPipePlan")
    (Document "psPlan.html")
    (Source "photoSch")
    (Division "TERMINATOR")
    (Persistence "PERSISTENT")
  )

  (Class "Primary Standard Field"
    (Name "Primary Standard Field")
    (Source "mtSch")
    (Description "A piece of sky, the size of the field of view of the MT, containing one or more primary standard stars.")
  )

  (Class "Primary Standard Star"
    (Name "Primary Standard Star")
    (Class "arMTPrimary")
    (Source "mtSch")
    (Description "A primary photometric and/or spectrophotometric standard star.")
    (Persistence "PERSISTENT")
  )

  (Class "Primary Standards Set"
    (Name "Primary Standards Set")
    (Class "arMTPrimarySet")
    (Description "A set of primary standard star fields.")
    (Persistence "PERSISTENT")
  )

  (Class "Product"
    (Name "Product")
    (Class "arProduct")
    (Source "adminSch")
    (Description "An abstract base class which links objectgs to the reports which created them.")
    (Type "ABSTRACT")
    (Persistence "PERSISTENT")
  )

  (Class "Quartile"
    (Name "Quartile")
    (Document "idGang.html")
    (Source "photoSch")
    (Description "Quartiles and mode for a single column in a raw frame.")
    (Concurrency "BLOCKING")
    (Persistence "PERSISTENT")
  )

  (Class "Radial Bin"
    (Name "Radial Bin")
    (Class "arRadialBin")
    (Source "photoSch")
  )

  (Class "Report"
    (Name "Report")
    (Class "arReport")
    (Source "adminSch")
    (Description "A report provides the fundamental mechanism for recording survey activities.")
    (Persistence "PERSISTENT")
  )

  (Class "Sector"
    (Name "Sector")
    (Class "arSector")
    (Source "strategySch")
    (Description "A single contiguous piece of a stripe, laid out for purposes of photometric calibration.")
    (Persistence "PERSISTENT")
  )

  (Class "Selected Field List"
    (Name "Selected Field List")
    (Description "A single run of te selection pipeline.  It assigns primary or secondary status to a set of object lists.")
    (Persistence "PERSISTENT")
  )

  (Class "Single Precision Measurement"
    (Name "Single Precision Measurement")
    (Class "arFloatErr")
    (Source "bbasicSch")
    (Description "A single precision floating point value with an associated single precision floating point variance.")
  )

  (Class "Small Object Detection"
    (Name "Small Object Detection")
    (Class "arSmallObject")
    (Source "photoSch")
  )

  (Class "Spectroscopic Target"
    (Name "Spectroscopic Target")
    (Class "arSpTarget")
    (Persistence "PERSISTENT")
  )

  (Class "Spherical Coordinate"
    (Name "Spherical Coordinate")
    (Class "arSphericalCoord")
    (Source "basicSch")
    (Description "A longitude-latitude pair in a spherical coordinate system.")
  )

  (Class "SSC Pipeline Plan"
    (Name "SSC Pipeline Plan")
    (Persistence "PERSISTENT")
  )

  (Class "SSC Pipeline Run"
    (Name "SSC Pipeline Run")
    (Class "arSSCPipeRun")
    (Source "photoSch")
    (Description "The results of a single run of the Serial Stamp Collection Pipeline.")
    (Persistence "PERSISTENT")
  )

  (Class "SSC Postage Stamp"
    (Name "SSC Postage Stamp")
    (Source "photoSch")
    (Description "Postage stamp cutout by the SSC pipeline to match a stamp cut out by the DA on a different frame in the same field.")
  )

  (Class "String Parameter Value "
    (Name "String Parameter Value ")
    (Class "arStrParamValue")
    (Source "adminSch")
    (Description "Stores a string value for a string parameter.")
    (Persistence "PERSISTENT")
  )

  (Class "Stripe"
    (Name "Stripe")
    (Class "arStripe")
    (Source "strategySch")
    (Description "A stripe consists of two overlapping strips, each strip containing six individual CCD scanlines.")
    (Persistence "PERSISTENT")
  )

  (Class "Survey Coordinate"
    (Name "Survey Coordinate")
    (Class "arSurveyCoord")
    (Source "strategySch")
    (Description "Survey coordinate.")
    (Derived "TRUE")
  )

  (Class "Target List"
    (Name "Target List")
  )

  (Class "TCC Info"
    (Name "TCC Info")
    (Class "arTCCInfo")
    (Document "idGang.html")
    (Source "photoSch")
    (Description "The TCC info for a set of frames by one imaging camera CPU.  All attributes are interpolated to when column 0 of row 0 was read.")
    (Division "ACTIVE")
    (Metaclass "TRUE")
  )

  (Class "Time Stamp"
    (Name "Time Stamp")
    (Class "arStamp")
    (Source "adminSch")
    (Description "A time stamp records an event, recording the time and date it occurred, the <<arPerson>>s responsible for it, and a comment.")
    (Persistence "PERSISTENT")
  )

  (Attribute "1"
    (Name "1")
    (Key_Number "0")
  )

  (Attribute "2"
    (Name "2")
    (Key_Number "0")
  )

  (Attribute "3"
    (Name "3")
    (Key_Number "0")
  )

  (Attribute "3\"apFlux w/err"
    (Name "3\"apFlux w/err")
    (Key_Number "0")
  )

  (Attribute "4"
    (Name "4")
    (Key_Number "0")
  )

  (Attribute "a"
    (Name "a")
    (Key_Number "0")
  )

  (Attribute "alt"
    (Name "alt")
    (Document "degrees")
    (Type "float32")
    (Initial_Value "XXX.XXXXXX")
    (Description "Altitude (encoder) of telescope.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "amps"
    (Name "amps")
    (Key_Number "0")
  )

  (Attribute "angleMajor"
    (Name "angleMajor")
    (Type "uint16")
    (Description "The major axis position angle in degrees (hundreths of a degree internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "angleMinor"
    (Name "angleMinor")
    (Type "uint16")
    (Description "The minor axis position angle in degrees (hundreths of a degree internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "angMajorAxis"
    (Name "angMajorAxis")
    (Document "degrees")
    (Type "float32")
    (Description "The major axis position angle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "angMinorAxis"
    (Name "angMinorAxis")
    (Document "degrees")
    (Type "float32")
    (Description "The minor axis position angle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "apcounts"
    (Name "apcounts")
    (Key_Number "0")
  )

  (Attribute "aperr"
    (Name "aperr")
    (Size "5")
    (Key_Number "0")
  )

  (Attribute "apFlux"
    (Name "apFlux")
    (Document "mag")
    (Type "float32")
    (Description "Flux through a 3 arcsec diameter circular aperture centered on the object.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "aprad"
    (Name "aprad")
    (Key_Number "0")
  )

  (Attribute "apRadius"
    (Name "apRadius")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "6.25")
    (Description "aperture radius for flux measurement (pixels)")
    (Key_Number "0")
  )

  (Attribute "ascendingNode"
    (Name "ascendingNode")
    (Key_Number "0")
  )

  (Attribute "az"
    (Name "az")
    (Document "degrees")
    (Type "float32")
    (Initial_Value "XXX.XXXXXX")
    (Description "Azimuth (encoder) of telescope.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "b"
    (Name "b")
    (Key_Number "0")
  )

  (Attribute "badmagfl"
    (Name "badmagfl")
    (Key_Number "0")
  )

  (Attribute "bias"
    (Name "bias")
    (Type "uint16")
    (Description "Number of columns of bias per amplifier.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "biasVector"
    (Name "biasVector")
    (Key_Number "0")
  )

  (Attribute "bitMap"
    (Name "bitMap")
    (Key_Number "0")
  )

  (Attribute "blend"
    (Name "blend")
    (Key_Number "0")
  )

  (Attribute "brightDir"
    (Name "brightDir")
    (Document "PARAM")
    (Type "string")
    (Description "directory of bright (primary) standard fits image files")
    (Key_Number "0")
  )

  (Attribute "bright_type"
    (Name "bright_type")
    (Key_Number "0")
  )

  (Attribute "bulge/disk w/prob"
    (Name "bulge/disk w/prob")
    (Key_Number "0")
  )

  (Attribute "bulgeDisk"
    (Name "bulgeDisk")
    (Type "float32")
    (Description "Bulge/disk ratio.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "bulgeDiskProb"
    (Name "bulgeDiskProb")
    (Type "float32")
    (Description "Probability/significance of bolge/disk ratio being correct.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "c"
    (Name "c")
    (Key_Number "0")
  )

  (Attribute "c0"
    (Name "c0")
    (Key_Number "0")
  )

  (Attribute "calDir"
    (Name "calDir")
    (Document "PARAM")
    (Type "string")
    (Description "directory containing flats and biases for MT")
    (Key_Number "0")
  )

  (Attribute "calDir  "
    (Name "calDir  ")
    (Document "PARAM")
    (Type "string")
    (Description "directory containing flats and biases for MT")
    (Key_Number "0")
  )

  (Attribute "caliFlavor"
    (Name "caliFlavor")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "Sec")
    (Description "Flavor of this calibration:  Pri or Sec")
    (Key_Number "0")
  )

  (Attribute "caliMatchRadius"
    (Name "caliMatchRadius")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "5.0")
    (Description "matching radius, UNITS: arcseconds")
    (Key_Number "0")
  )

  (Attribute "calReport"
    (Name "calReport")
    (Document "PARAM")
    (Description "Name of Calibration report file")
    (Key_Number "0")
  )

  (Attribute "camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "camRow"
    (Name "camRow")
    (Type "uint8")
    (Description "Row in the imaging camera.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "ccd"
    (Name "ccd")
    (Key_Number "0")
  )

  (Attribute "ccdcol"
    (Name "ccdcol")
    (Key_Number "0")
  )

  (Attribute "ccdow"
    (Name "ccdow")
    (Key_Number "0")
  )

  (Attribute "ccdrow"
    (Name "ccdrow")
    (Key_Number "0")
  )

  (Attribute "ccSecondMoment"
    (Name "ccSecondMoment")
    (Type "float32")
    (Description "The column-column second moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "chiSq"
    (Name "chiSq")
    (Type "float32")
    (Description "Chi-square of the fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "Class"
    (Name "Class")
    (Key_Number "0")
  )

  (Attribute "classification"
    (Name "classification")
    (Key_Number "0")
  )

  (Attribute "classification w/prob"
    (Name "classification w/prob")
    (Key_Number "0")
  )

  (Attribute "classificationProb"
    (Name "classificationProb")
    (Type "arFloatErr")
    (Description "Probablity/significance of classification being correct.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "clockRate"
    (Name "clockRate")
    (Key_Number "0")
  )

  (Attribute "col"
    (Name "col")
    (Key_Number "0")
  )

  (Attribute "col0"
    (Name "col0")
    (Key_Number "0")
  )

  (Attribute "col1"
    (Name "col1")
    (Type "uint16")
    (Description "First binned column read.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "colAmp"
    (Name "colAmp")
    (Document "ADUs")
    (Type "float32")
    (Description "The column amplitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "colAmplitude"
    (Name "colAmplitude")
    (Key_Number "0")
  )

  (Attribute "colBin"
    (Name "colBin")
    (Type "uint16")
    (Description "The binning factor perpendicular to the columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "colBinning"
    (Name "colBinning")
    (Key_Number "0")
  )

  (Attribute "colc"
    (Name "colc")
    (Key_Number "0")
  )

  (Attribute "colCenter"
    (Name "colCenter")
    (Type "float32")
    (Description "Column position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )

  (Attribute "colCentroid"
    (Name "colCentroid")
    (Type "float32")
    (Description "Column position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )

  (Attribute "colcerr"
    (Name "colcerr")
    (Key_Number "0")
  )

  (Attribute "colColQuadMoment"
    (Name "colColQuadMoment")
    (Key_Number "0")
  )

  (Attribute "colorFilter(g)"
    (Name "colorFilter(g)")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "r 0")
    (Description "Name of color term filter and sign flag")
    (Key_Number "0")
  )

  (Attribute "colorFilter(i)"
    (Name "colorFilter(i)")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "z 0")
    (Description "Name of color term filter and sign flag (1 for blueward cast)")
    (Key_Number "0")
  )

  (Attribute "colorFilter(r)"
    (Name "colorFilter(r)")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "i 0")
    (Description "Name of color term filter and sign flag")
    (Key_Number "0")
  )

  (Attribute "colorFilter(u)"
    (Name "colorFilter(u)")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "g 0")
    (Description "Name of corresponding color term filter and sign flag (0 = redward, 1=blueward)")
    (Key_Number "0")
  )

  (Attribute "colorFilter(z)"
    (Name "colorFilter(z)")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "i 1")
    (Description "color term filter and sign flag")
    (Key_Number "0")
  )

  (Attribute "colReducedChi2"
    (Name "colReducedChi2")
    (Type "float32")
    (Description "The chi2 in the fits to the lines.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "colSigma"
    (Name "colSigma")
    (Key_Number "0")
  )

  (Attribute "colSky"
    (Name "colSky")
    (Key_Number "0")
  )

  (Attribute "column"
    (Name "column")
    (Key_Number "0")
  )

  (Attribute "columns"
    (Name "columns")
    (Type "STRING")
    (Initial_Value "1 2 3 4 5 6")
    (Description "A space-separated list of column numbers to process.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "comment"
    (Name "comment")
    (Key_Number "0")
  )

  (Attribute "coord"
    (Name "coord")
    (Type "arSphericalCoord")
    (Description "The right ascension and declination of the telescope boresight when column 0 or row 0 was read.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "coordEquinox"
    (Name "coordEquinox")
    (Type "float64")
    (Description "Equinox, in years, of the telescope coordinates stored in each associated frame.")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "coordSystem"
    (Name "coordSystem")
    (Type "arGCSystem")
    (Description "The system of coordinates used for telescope coordinates attached to each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "counts"
    (Name "counts")
    (Key_Number "0")
  )

  (Attribute "cpu"
    (Name "cpu")
    (Type "uint8")
    (Description "Image DA cpu which produced the set of frames.")
    (Scope "IMPLEMENTATION")
    (Key "PRIMARY")
    (Key_Number "0")
  )

  (Attribute "creationTime"
    (Name "creationTime")
    (Key_Number "0")
  )

  (Attribute "c_obs"
    (Name "c_obs")
    (Document "usec/row")
    (Type "float32")
    (Description "The CCD row clock rate.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "d"
    (Name "d")
    (Key_Number "0")
  )

  (Attribute "darkTime"
    (Name "darkTime")
    (Document "seconds")
    (Type "float32")
    (Description "Dark time.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "dataType"
    (Name "dataType")
    (Key_Number "0")
  )

  (Attribute "dec"
    (Name "dec")
    (Type "float64")
    (Description "The declination of the telescope boresight pointing when row 0 of column 0 was read, in degrees.")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "decerr"
    (Name "decerr")
    (Key_Number "0")
  )

  (Attribute "description"
    (Name "description")
    (Key_Number "0")
  )

  (Attribute "diskLikelihood"
    (Name "diskLikelihood")
    (Document "%")
    (Type "float32")
    (Description "Likelihood of object being a disk galaxy.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )

  (Attribute "e"
    (Name "e")
    (Key_Number "0")
  )

  (Attribute "eccentricity"
    (Name "eccentricity")
    (Key_Number "0")
  )

  (Attribute "edgeFlag"
    (Name "edgeFlag")
    (Key_Number "0")
  )

  (Attribute "ellipLik"
    (Name "ellipLik")
    (Key_Number "0")
  )

  (Attribute "ellipLikelihood"
    (Name "ellipLikelihood")
    (Document "%")
    (Type "float32")
    (Description "Likelihood of object being an elliptical galaxy.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )

  (Attribute "email"
    (Name "email")
    (Key_Number "0")
  )

  (Attribute "endField"
    (Name "endField")
    (Type "uint16")
    (Description "Field at which to start processing.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "endLambda"
    (Name "endLambda")
    (Document "degrees")
    (Type "float64")
    (Description "The ending survey \"longitude\" of the stripe.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "endTime"
    (Name "endTime")
    (Type "arTime")
    (Description "End of time range over which this is valid.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "eqninox"
    (Name "eqninox")
    (Document "years")
    (Type "float64")
    (Description "Equinox of the TCC coordinates.   These are the coordinates stored in each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "eqnx_coo"
    (Name "eqnx_coo")
    (Document "years")
    (Type "float64")
    (Description "The equinox of the telescope coordinates stored in each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "eqnx_scn"
    (Name "eqnx_scn")
    (Document "years")
    (Type "float64")
    (Description "The equinox of the scan great circle definition.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "eqnx_tcc"
    (Name "eqnx_tcc")
    (Document "years")
    (Type "float64")
    (Description "The equinox of the telescope coordinates stored in each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "equinox"
    (Name "equinox")
    (Key_Number "0")
  )

  (Attribute "eta"
    (Name "eta")
    (Key_Number "0")
  )

  (Attribute "etaerr"
    (Name "etaerr")
    (Key_Number "0")
  )

  (Attribute "etc."
    (Name "etc.")
    (Key_Number "0")
  )

  (Attribute "excalAstromPAoff"
    (Name "excalAstromPAoff")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "90.0")
    (Description "default rotation for matching MT CCD to sky")
    (Key_Number "0")
  )

  (Attribute "excalAstromParity"
    (Name "excalAstromParity")
    (Document "PARAM")
    (Type "int")
    (Initial_Value "-1")
    (Description "sky flip (-1) ")
    (Key_Number "0")
  )

  (Attribute "excalAstromPaWindow"
    (Name "excalAstromPaWindow")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "0.5")
    (Description "Error allowed in Position angle in bi-match separations (degrees)")
    (Key_Number "0")
  )

  (Attribute "excalAstromSepWindow"
    (Name "excalAstromSepWindow")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "0.01")
    (Description "fractional error allowed in bi-match separations ")
    (Key_Number "0")
  )

  (Attribute "excalFlavor"
    (Name "excalFlavor")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "Pri")
    (Description "flavor of observation that excal works on (primary standard)")
    (Key_Number "0")
  )

  (Attribute "excalMatchRadius"
    (Name "excalMatchRadius")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "5.0")
    (Description "Matching radius (arcsec)")
    (Key_Number "0")
  )

  (Attribute "excalMinAstromMatches"
    (Name "excalMinAstromMatches")
    (Document "PARAM")
    (Type "int")
    (Initial_Value "6")
    (Description "minimum allowed matches for bi-match match to be deemed valid")
    (Key_Number "0")
  )

  (Attribute "expTime"
    (Name "expTime")
    (Document "seconds")
    (Type "float32")
    (Description "Exposure time.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "ext"
    (Name "ext")
    (Size "5")
    (Key_Number "0")
  )

  (Attribute "exterr"
    (Name "exterr")
    (Key_Number "0")
  )

  (Attribute "extras"
    (Name "extras")
    (Type "bool")
    (Description "Have extra targets (i.e., serendipity and stars) been selected yet?")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )

  (Attribute "f"
    (Name "f")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "faintDir"
    (Name "faintDir")
    (Document "PARAM")
    (Type "string")
    (Description "directory containing faint (secondary) MT standard patch fits files")
    (Key_Number "0")
  )

  (Attribute "faint_type"
    (Name "faint_type")
    (Key_Number "0")
  )

  (Attribute "fax"
    (Name "fax")
    (Attribute "_fax")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "fid"
    (Name "fid")
    (Key_Number "0")
  )

  (Attribute "field"
    (Name "field")
    (Key_Number "0")
  )

  (Attribute "field id"
    (Name "field id")
    (Key_Number "0")
  )

  (Attribute "field0"
    (Name "field0")
    (Key_Number "0")
  )

  (Attribute "filter"
    (Name "filter")
    (Attribute "_filter")
    (Type "arMTFilter")
    (Description "The filter through which this exposure was taken.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "filters"
    (Name "filters")
    (Key_Number "0")
  )

  (Attribute "filtr"
    (Name "filtr")
    (Key_Number "0")
  )

  (Attribute "firstName"
    (Name "firstName")
    (Attribute "_firstName")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "flag"
    (Name "flag")
    (Type "uint8")
    (Description "Flags.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "flags"
    (Name "flags")
    (Key_Number "0")
  )

  (Attribute "flatFieldVector"
    (Name "flatFieldVector")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "flavor"
    (Name "flavor")
    (Attribute "_flavor")
    (Type "arMTSequenceFlavor")
    (Description "Flavor of this sequence (e.g., dome flat, primary standard, calibration patch, etc).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "focus"
    (Name "focus")
    (Document "microns")
    (Type "float32")
    (Description "Focus position (encoder).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "frame"
    (Name "frame")
    (Type "uint16")
    (Description "Frame number.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "fwhm"
    (Name "fwhm")
    (Attribute "_fwhm")
    (Type "o_float")
    (Description "Full-width-half-maximum of the profile in pixels.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "g"
    (Name "g")
    (Document "mag")
    (Type "arMag")
    (Description "SDSS g magnitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "greatCircleIncl"
    (Name "greatCircleIncl")
    (Attribute "_greatCircleIncl")
    (Type "o_double")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "gscDir"
    (Name "gscDir")
    (Document "PARAM")
    (Type "string")
    (Description "directory containing binary fits files with lists of GSC stars in secondary MT patches")
    (Key_Number "0")
  )

  (Attribute "hi"
    (Name "hi")
    (Key_Number "0")
  )

  (Attribute "hip"
    (Name "hip")
    (Key_Number "0")
  )

  (Attribute "hippie"
    (Name "hippie")
    (Key_Number "0")
  )

  (Attribute "hipps"
    (Name "hipps")
    (Key_Number "0")
  )

  (Attribute "i"
    (Name "i")
    (Document "mag")
    (Type "arMag")
    (Description "SDSS i magnitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "id"
    (Name "id")
    (Attribute "_id")
    (Type "o_u4b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "incl"
    (Name "incl")
    (Document "degrees")
    (Type "float64")
    (Description "The inclination with respect to the celestial equator of the great circle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "inclination"
    (Name "inclination")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "incl_obs"
    (Name "incl_obs")
    (Document "degrees")
    (Type "float64")
    (Description "The inclination with respect to the celestial equator of the great circle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "innerSky"
    (Name "innerSky")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "12.0")
    (Description "inner sky annulus radius for MT photometry (pixels)")
    (Key_Number "0")
  )

  (Attribute "ipa"
    (Name "ipa")
    (Document "degrees")
    (Type "float32")
    (Description "The angle of the instrument rotator.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "ipaRate"
    (Name "ipaRate")
    (Document "degrees/sec")
    (Type "float32")
    (Description "Instrument rotator angular velocity when column 0 of row 0 was read.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "k"
    (Name "k")
    (Size "5")
    (Key_Number "0")
  )

  (Attribute "knownColorFilterList"
    (Name "knownColorFilterList")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "u g r i z")
    (Description "List of filters (in order) for the MT")
    (Key_Number "0")
  )

  (Attribute "lambda"
    (Name "lambda")
    (Key_Number "0")
  )

  (Attribute "lambdaerr"
    (Name "lambdaerr")
    (Key_Number "0")
  )

  (Attribute "lastName"
    (Name "lastName")
    (Attribute "_lastName")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "latitude"
    (Name "latitude")
    (Type "o_double")
    (Description "Longitude in degrees.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )

  (Attribute "lbias"
    (Name "lbias")
    (Document "???")
    (Type "float32")
    (Description "Left-hand bias level.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "lineAmp"
    (Name "lineAmp")
    (Document "ADUs")
    (Type "float32")
    (Description "The line amplitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "lineCenter"
    (Name "lineCenter")
    (Type "float32")
    (Description "Row position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "lineCentroid"
    (Name "lineCentroid")
    (Type "float32")
    (Description "Row position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "lineReducedChi2"
    (Name "lineReducedChi2")
    (Type "float32")
    (Description "The chi2 in the fits to the lines.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "lineSigma"
    (Name "lineSigma")
    (Document "pixels")
    (Type "float32")
    (Description "The uncertainty in the x position.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "lineSky"
    (Name "lineSky")
    (Document "ADUs")
    (Type "float32")
    (Description "The sky value when fitting the rows.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "longitude"
    (Name "longitude")
    (Type "o_double")
    (Description "Latitude in degrees.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )

  (Attribute "mag"
    (Name "mag")
    (Size "5")
    (Key_Number "0")
  )

  (Attribute "mag20"
    (Name "mag20")
    (Document "???")
    (Type "float32")
    (Description "Flux corresponding to a 20th magnitude object.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "mag20err"
    (Name "mag20err")
    (Document "electrons")
    (Type "float32")
    (Description "Error in mag20.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "magerr"
    (Name "magerr")
    (Size "5")
    (Key_Number "0")
  )

  (Attribute "majorAxisAngle"
    (Name "majorAxisAngle")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "majorAxisRadius"
    (Name "majorAxisRadius")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "matchRadius"
    (Name "matchRadius")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "5.0")
    (Description "match radius (arcsec)")
    (Key_Number "0")
  )

  (Attribute "maxPix"
    (Name "maxPix")
    (Type "float32")
    (Description "Maximum pixel value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "mean"
    (Name "mean")
    (Key_Number "0")
  )

  (Attribute "meanPix"
    (Name "meanPix")
    (Type "float32")
    (Description "Mean pixel value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "meanPixelFlux"
    (Name "meanPixelFlux")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "median"
    (Name "median")
    (Key_Number "0")
  )

  (Attribute "medianPixelFlux"
    (Name "medianPixelFlux")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "merged"
    (Name "merged")
    (Type "bool")
    (Description "Have the objects detected in this pipeline run been merged with other objects in the database?")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )

  (Attribute "midCol"
    (Name "midCol")
    (Type "uint16")
    (Description "The frame column corresponding to the middle pixel of the postage stamp.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "midLine"
    (Name "midLine")
    (Type "uint16")
    (Description "The frame row corresponding to the middle pixel of the postage stamp.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "midRow"
    (Name "midRow")
    (Type "uint16")
    (Description "Frame row of the stamp's middle pixel.  The location is with respect to the data section.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "minorAxisAngle"
    (Name "minorAxisAngle")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "minorAxisRadius"
    (Name "minorAxisRadius")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "minPix"
    (Name "minPix")
    (Document "electrons")
    (Type "float32")
    (Description "Minimum pixel value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "mode"
    (Name "mode")
    (Type "int32")
    (Description "Mode.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "name"
    (Name "name")
    (Attribute "_name")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "nBadPix"
    (Name "nBadPix")
    (Type "uint16")
    (Description "Number of bad pixels in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "nBrightObj"
    (Name "nBrightObj")
    (Type "uint16")
    (Description "Number of bright objects detected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "nCols"
    (Name "nCols")
    (Attribute "_nCols")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "nCol_obs"
    (Name "nCol_obs")
    (Type "uint16")
    (Description "The number of binned data columns read per frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "nFaintObj"
    (Name "nFaintObj")
    (Type "uint16")
    (Description "Number of faint objects detected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "nGalaxies"
    (Name "nGalaxies")
    (Type "uint16")
    (Description "Number of objects classified as galaxies.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "nObjects"
    (Name "nObjects")
    (Type "uint16")
    (Description "Number of objects detected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "node"
    (Name "node")
    (Key_Number "0")
  )

  (Attribute "node_obs"
    (Name "node_obs")
    (Document "degrees")
    (Type "float64")
    (Description "The right ascension of the ascending node of the great circle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "nprofid"
    (Name "nprofid")
    (Key_Number "0")
  )

  (Attribute "nRows"
    (Name "nRows")
    (Attribute "_nRows")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "nStars"
    (Name "nStars")
    (Type "uint16")
    (Description "Number of objects classified as stars.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "numberColPixels"
    (Name "numberColPixels")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "numberRowPixels"
    (Name "numberRowPixels")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "numColPixels"
    (Name "numColPixels")
    (Type "uint16")
    (Description "The number of pixels used to fit the column marginals.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "numLinePixels"
    (Name "numLinePixels")
    (Type "uint16")
    (Description "The number of pixels used to fit the row margnials.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "numRowPixels"
    (Name "numRowPixels")
    (Type "uint16")
    (Description "Number of pixels for row fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "objclass"
    (Name "objclass")
    (Key_Number "0")
  )

  (Attribute "objectLink"
    (Name "objectLink")
    (Type "ooHandle(ooObj)")
    (Description "Link to the object which is the value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "objectMask"
    (Name "objectMask")
    (Key_Number "0")
  )

  (Attribute "objectParameters"
    (Name "objectParameters")
    (Attribute "_objectParameters")
    (Type "VVIDictionary<VString, PObject>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "outDir"
    (Name "outDir")
    (Document "PARAM")
    (Type "string")
    (Description "output directory for .mtstd and .mtext files")
    (Key_Number "0")
  )

  (Attribute "outerSky"
    (Name "outerSky")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "24.0")
    (Description "outer radius of sky annulus for photometry")
    (Key_Number "0")
  )

  (Attribute "overscan"
    (Name "overscan")
    (Attribute "_overscan")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "parentid"
    (Name "parentid")
    (Key_Number "0")
  )

  (Attribute "peakCol"
    (Name "peakCol")
    (Type "o_u2b")
    (Description "Column of the peak pixel.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "peakCounts"
    (Name "peakCounts")
    (Attribute "_peakCounts")
    (Type "o_float")
    (Description "Sky subtracted counts (ADUs) in the peak pixel.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "peakRow"
    (Name "peakRow")
    (Attribute "_peakRow")
    (Type "o_u2b")
    (Description "Row of the peak pixel.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "pertrosianFlux"
    (Name "pertrosianFlux")
    (Document "electrons")
    (Type "arFloatErr")
    (Description "Flux within the petrosian radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "pertrosianFlux w/err"
    (Name "pertrosianFlux w/err")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "petrorad"
    (Name "petrorad")
    (Key_Number "0")
  )

  (Attribute "petrosianFlux"
    (Name "petrosianFlux")
    (Document "electrons")
    (Type "arFloatErr")
    (Description "Flux within the petrosian radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "petrosianRadius"
    (Name "petrosianRadius")
    (Document "pixels")
    (Type "arFloatErr")
    (Description "Petrosian radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "petrosianRadius w/err"
    (Name "petrosianRadius w/err")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "phone"
    (Name "phone")
    (Attribute "_phone")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "pixelMap"
    (Name "pixelMap")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
  )

  (Attribute "pixelScale"
    (Name "pixelScale")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "0.80")
    (Description "scale of MT CCD in arcsec/pixel")
    (Key_Number "0")
  )

  (Attribute "positionAngle"
    (Name "positionAngle")
    (Attribute "_PA")
    (Type "o_float")
    (Description "Position angle, in degrees, measured north from east.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "prescan"
    (Name "prescan")
    (Attribute "_prescan")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "primaryFilter"
    (Name "primaryFilter")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "r")
    (Description "primary filter for object detection and matching")
    (Key_Number "0")
  )

  (Attribute "primCatVsn"
    (Name "primCatVsn")
    (Description "Version of the primary astrometric standard star catalog used.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "priority"
    (Name "priority")
    (Type "uint16")
    (Description "Execution priority.  1 is highest, then 2, 3, ...")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "psets"
    (Name "psets")
    (Attribute "_psets")
    (Type "BiLinkVstr<arPset>")
    (Key_Number "0")
  )

  (Attribute "psf"
    (Name "psf")
    (Description "Point spread function.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "psfB"
    (Name "psfB")
    (Type "float32")
    (Description "Ratio of the second PSF to the first PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "psfFlux"
    (Name "psfFlux")
    (Document "electrons")
    (Type "arFloatErr")
    (Description "Flux measured via convolution with the PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "psfFlux w/err"
    (Name "psfFlux w/err")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "psfSigX1"
    (Name "psfSigX1")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along rows for first PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "psfSigX2"
    (Name "psfSigX2")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along rows for second PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "psfSigY1"
    (Name "psfSigY1")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along columns for first PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "psfSigY2"
    (Name "psfSigY2")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along columns for second PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "Q1"
    (Name "Q1")
    (Type "int32")
    (Description "25th percentile.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "Q2"
    (Name "Q2")
    (Type "int32")
    (Description "50th percentile.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "Q3"
    (Name "Q3")
    (Type "int32")
    (Description "75th percentile.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "quadMomCC"
    (Name "quadMomCC")
    (Type "uint16")
    (Description "The column-column second moment in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomentCC"
    (Name "quadMomentCC")
    (Type "uint16")
    (Description "The column-column second moment in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomentRC"
    (Name "quadMomentRC")
    (Type "uint16")
    (Description "The row-column second moment in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomentRR"
    (Name "quadMomentRR")
    (Type "uint16")
    (Description "The row-row second moment in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomLC"
    (Name "quadMomLC")
    (Type "uint16")
    (Description "The row-column second moment in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomLL"
    (Name "quadMomLL")
    (Type "uint16")
    (Description "The row-row second moment in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomRC"
    (Name "quadMomRC")
    (Document "pixels")
    (Type "float32")
    (Description "The line-column (xy) 2nd moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quadMomRR"
    (Name "quadMomRR")
    (Document "pixels")
    (Type "float32")
    (Description "The line-line (xx) 2nd moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "quality"
    (Name "quality")
    (Attribute "_quality")
    (Type "arDataQuality")
    (Key_Number "0")
  )

  (Attribute "r"
    (Name "r")
    (Type "ffloat64")
    (Description "The right ascension of the telescope boresight pointing when row 0 of column 0 of the chip was read, in degrees.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "ra"
    (Name "ra")
    (Type "ffloat64")
    (Description "The right ascension of the telescope boresight pointing when row 0 of column 0 of the chip was read..")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rad"
    (Name "rad")
    (Key_Number "0")
  )

  (Attribute "radiusMajor"
    (Name "radiusMajor")
    (Type "uint16")
    (Description "The major axis radius in pixels (hundreths of a pixel internally). ")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "radiusMinor"
    (Name "radiusMinor")
    (Type "uint16")
    (Description "The minor axis radius in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "raerr"
    (Name "raerr")
    (Key_Number "0")
  )

  (Attribute "rbias"
    (Name "rbias")
    (Document "???")
    (Type "float32")
    (Description "Right-hand bias level.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "rcSecondMoment"
    (Name "rcSecondMoment")
    (Type "float32")
    (Description "The row-column second moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "reportDir"
    (Name "reportDir")
    (Document "PARAM")
    (Description "directory where reports are stored")
    (Key_Number "0")
  )

  (Attribute "reviewed"
    (Name "reviewed")
    (Type "arStamp")
    (Description "Time stamp recording when it was reviewed.  Initially set to a NULL time stamp.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rMajor"
    (Name "rMajor")
    (Type "uint16")
    (Description "The major axis radius in pixels (hundreths of a pixel internally). ")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rMinor"
    (Name "rMinor")
    (Type "uint16")
    (Description "The minor axis radius in pixels (hundreths of a pixel internally).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rotationAngle"
    (Name "rotationAngle")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rotatorAngle"
    (Name "rotatorAngle")
    (Type "float32")
    (Description "The angle, in degrees, of the instrument rotator.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "row"
    (Name "row")
    (Attribute "_row")
    (Type "arFloatErr")
    (Description "Centroided row position.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "row0"
    (Name "row0")
    (Key_Number "0")
  )

  (Attribute "row1"
    (Name "row1")
    (Attribute "_row1")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "rowAmp"
    (Name "rowAmp")
    (Document "ADUs")
    (Type "float32")
    (Description "Amplitude of fit along the row margnial.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "rowAmplitude"
    (Name "rowAmplitude")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rowBin"
    (Name "rowBin")
    (Type "uint16")
    (Description "The binning factor perpendicular to the rows.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "rowBinning"
    (Name "rowBinning")
    (Attribute "_rowBinning")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "rowc"
    (Name "rowc")
    (Key_Number "0")
  )

  (Attribute "rowCenter"
    (Name "rowCenter")
    (Type "float32")
    (Description "Mean for the row marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )

  (Attribute "rowCentroid"
    (Name "rowCentroid")
    (Type "float32")
    (Description "Line position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rowcerr"
    (Name "rowcerr")
    (Key_Number "0")
  )

  (Attribute "rowColQuadMoment"
    (Name "rowColQuadMoment")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rowReducedChi2"
    (Name "rowReducedChi2")
    (Type "float32")
    (Description "Reduced chi-quare of the row fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "rowRowQuadMoment"
    (Name "rowRowQuadMoment")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rows"
    (Name "rows")
    (Type "STRING")
    (Initial_Value "1 2 3 4 5")
    (Description "A space-separated list of row numbers to process.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "rowSigma"
    (Name "rowSigma")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rowSky"
    (Name "rowSky")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "rowWidth"
    (Name "rowWidth")
    (Attribute "_rowWidth")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "rrSecondMoment"
    (Name "rrSecondMoment")
    (Type "float32")
    (Description "The row-row second moment (Iyy).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "run"
    (Name "run")
    (Description "mjd")
    (Key_Number "0")
  )

  (Attribute "run "
    (Name "run ")
    (Key_Number "0")
  )

  (Attribute "run id"
    (Name "run id")
    (Key_Number "0")
  )

  (Attribute "runNumber"
    (Name "runNumber")
    (Document "PARAM")
    (Type "int32")
    (Description "int(MJD)")
    (Key_Number "0")
  )

  (Attribute "scanEquinox"
    (Name "scanEquinox")
    (Type "float64")
    (Description "The equinox of the scan great circle definition.")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "scanSystem"
    (Name "scanSystem")
    (Type "arGCSystem")
    (Description "The system of scan great circle coordinates used.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "scanTime"
    (Name "scanTime")
    (Type "float32")
    (Description "The length of the scan in seconds.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "scan_sys"
    (Name "scan_sys")
    (Type "arGCSystem")
    (Description "The system of scan great circle coordinates used.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "sequence"
    (Name "sequence")
    (Type "o_u4b")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "sequence#"
    (Name "sequence#")
    (Type "o_u4b")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "sidescan"
    (Name "sidescan")
    (Attribute "_sidescan")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "sigmaAboveSky"
    (Name "sigmaAboveSky")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "10.0")
    (Description "how many sigma above sky")
    (Key_Number "0")
  )

  (Attribute "sigmaClipIterations"
    (Name "sigmaClipIterations")
    (Document "PARAM")
    (Type "string")
    (Initial_Value "1")
    (Description "how many times")
    (Key_Number "0")
  )

  (Attribute "sigmaClipSigma"
    (Name "sigmaClipSigma")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "4.0")
    (Description "clip at sigma")
    (Key_Number "0")
  )

  (Attribute "sigmax1"
    (Name "sigmax1")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along rows for the first PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "sigmax2"
    (Name "sigmax2")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along the rows for the second PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "sigmay1"
    (Name "sigmay1")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along columns for the first PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "sigmay2"
    (Name "sigmay2")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along the columns for the second PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "sigPix"
    (Name "sigPix")
    (Type "float32")
    (Description "Sqare root of the variance of pixel values in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "sky"
    (Name "sky")
    (Document "???")
    (Type "float32")
    (Description "The average sky value in the frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "skyAngle"
    (Name "skyAngle")
    (Type "float32")
    (Description "The angle, in degrees, of the N-S axis of the camera with respect to the meridian.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "skyCounts"
    (Name "skyCounts")
    (Attribute "_skyCounts")
    (Type "arFloatErr")
    (Description "Total sky counts (ADUs) inside aperture.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "skylevel"
    (Name "skylevel")
    (Key_Number "0")
  )

  (Attribute "skysigma"
    (Name "skysigma")
    (Key_Number "0")
  )

  (Attribute "skySlope"
    (Name "skySlope")
    (Document "??? per pixel")
    (Type "float32")
    (Description "The slope in the sky value along the columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "spa"
    (Name "spa")
    (Document "degrees")
    (Type "float32")
    (Description "The angle of the N-S axis of the camera with respect to the meridian.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "stampMiddleCol"
    (Name "stampMiddleCol")
    (Type "uint16")
    (Description "The frame column corresponding to the middle pixel of the postage stamp.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "stampMiddleLine"
    (Name "stampMiddleLine")
    (Type "uint16")
    (Description "The frame row corresponding to the middle pixel of the postage stamp.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "stampThresh"
    (Name "stampThresh")
    (Document "ADUs")
    (Type "float32")
    (Description "(Boundard) stamp trheshold.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "starLikelyhood"
    (Name "starLikelyhood")
    (Type "float32")
    (Description "Likelihood (1-100%) of object being a star.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )

  (Attribute "startField"
    (Name "startField")
    (Type "uint16")
    (Description "Field at which to start processing.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "startLambda"
    (Name "startLambda")
    (Document "degrees")
    (Type "float64")
    (Description "The beginning survey \"longitude\" of the stripe.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "startTime"
    (Name "startTime")
    (Attribute "_startTime")
    (Type "VTime")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "status"
    (Name "status")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )

  (Attribute "statusFit"
    (Name "statusFit")
    (Type "uint16")
    (Description "0=ok, less than 0 implies error.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "stddev"
    (Name "stddev")
    (Key_Number "0")
  )

  (Attribute "stdDir"
    (Name "stdDir")
    (Document "PARAM")
    (Type "string")
    (Description "directory containing pattern match files for primary MT standards")
    (Key_Number "0")
  )

  (Attribute "stoke1"
    (Name "stoke1")
    (Type "float32")
    (Description "First stoke parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "stoke2"
    (Name "stoke2")
    (Type "float32")
    (Description "Second stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "stoke3"
    (Name "stoke3")
    (Type "float32")
    (Description "Third Stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "stoke4"
    (Name "stoke4")
    (Type "float32")
    (Description "Fourth Stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "stokeParameter1"
    (Name "stokeParameter1")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "stokeParameter2"
    (Name "stokeParameter2")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "stokeParameter3"
    (Name "stokeParameter3")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "stokeParameter4"
    (Name "stokeParameter4")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "str"
    (Name "str")
    (Key_Number "0")
  )

  (Attribute "stringParameters"
    (Name "stringParameters")
    (Attribute "_stringParameters")
    (Type "VVIDictionary<VString, VString>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "strip"
    (Name "strip")
    (Type "arStrip")
    (Description "The strip in the stripe being tracked.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "sumWeights"
    (Name "sumWeights")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "surfaceBrightness"
    (Name "surfaceBrightness")
    (Document "electrons/pixel")
    (Type "arFloatErr")
    (Description "Mean surface brightness within the petrosian radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "surfaceBrightness w/err"
    (Name "surfaceBrightness w/err")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "system"
    (Name "system")
    (Type "arGCSystem")
    (Description "The system of great circle coordinates used.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "sys_coo"
    (Name "sys_coo")
    (Type "arGCSystem")
    (Description "The system of coordinates used for telescope coordinates attached to each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "sys_scn"
    (Name "sys_scn")
    (Type "arGCSystem")
    (Description "The system of scan great circle coordinates used.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "sys_tcc"
    (Name "sys_tcc")
    (Type "arGCSystem")
    (Description "The system of coordinates used for telescope coordinates attached to each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )

  (Attribute "TAI"
    (Name "TAI")
    (Type "sdbTime")
    (Key_Number "0")
  )

  (Attribute "tai_obs"
    (Name "tai_obs")
    (Type "TIME")
    (Description "The TAI at start of scan.")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "tai_scan"
    (Name "tai_scan")
    (Type "TIME")
    (Description "The TAI at start of scan.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "tai_scn"
    (Name "tai_scn")
    (Type "TIME")
    (Description "TAI at the start of scan.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "targetDate"
    (Name "targetDate")
    (Type "DATE")
    (Description "The UT date on which the plan should be carried out.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "telescopePointing"
    (Name "telescopePointing")
    (Type "arEquatorialCoord")
    (Description "The equatorial coordinates of the telescope boresight pointing.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "time"
    (Name "time")
    (Key_Number "0")
  )

  (Attribute "totalFlux"
    (Name "totalFlux")
    (Document "electrons")
    (Type "arFloatErr")
    (Description "Total flux.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "totalFlux w/err"
    (Name "totalFlux w/err")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "type"
    (Name "type")
    (Type "arMTCoefficient")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "type of target"
    (Name "type of target")
    (Description "galaxy qso sta serendip standard first other")
    (Key_Number "0")
  )

  (Attribute "u"
    (Name "u")
    (Type "arMag")
    (Description "SDSS u magnitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "uniqueObjectRadius"
    (Name "uniqueObjectRadius")
    (Document "PARAM")
    (Type "float32")
    (Initial_Value "2.0")
    (Description "unique object radius for MT objects (arcsec)")
    (Key_Number "0")
  )

  (Attribute "value"
    (Name "value")
    (Description "The value and error of the coeeficient.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "variance"
    (Name "variance")
    (Type "o_float")
    (Description "The variance in the measured value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )

  (Attribute "version"
    (Name "version")
    (Attribute "_version")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "widthCov"
    (Name "widthCov")
    (Attribute "_widthCovariance")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "w_xx"
    (Name "w_xx")
    (Key_Number "0")
  )

  (Attribute "w_xy"
    (Name "w_xy")
    (Key_Number "0")
  )

  (Attribute "w_yy"
    (Name "w_yy")
    (Key_Number "0")
  )

  (Attribute "x"
    (Name "x")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "x w/err"
    (Name "x w/err")
    (Attribute "x")
    (Type "arFloatErr")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "xBore"
    (Name "xBore")
    (Type "float32")
    (Description "The boresight x offset from the center of the array in mm.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "xBoreOffset"
    (Name "xBoreOffset")
    (Attribute "_xBoreOffset")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "xrevert-bufccdcol"
    (Name "xrevert-bufccdcol")
    (Key "SECONDARY")
    (Key_Number "0")
  )

  (Attribute "y"
    (Name "y")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "y w/err"
    (Name "y w/err")
    (Type "arFloatErr")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )

  (Attribute "yBore"
    (Name "yBore")
    (Type "float32")
    (Description "The boresight y offset from the center of the array in mm.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "yBoreOffset"
    (Name "yBoreOffset")
    (Attribute "_yBoreOffset")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "z"
    (Name "z")
    (Document "mag")
    (Type "arMag")
    (Initial_Value "XX.XXX")
    (Description "SDSS i magnitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )

  (Attribute "_action"
    (Name "_action")
    (Attribute "_action")
    (Type "Link<arAction>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_airmass"
    (Name "_airmass")
    (Attribute "_airmass")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_amps"
    (Name "_amps")
    (Attribute "_amps")
    (Type "VEEDictionary<o_u4b, o_u4b>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_ascendingNode"
    (Name "_ascendingNode")
    (Attribute "_ascendingNode")
    (Type "o_double")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_authors"
    (Name "_authors")
    (Attribute "_authors")
    (Type "LinkVstr<arPerson>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_calibrations"
    (Name "_calibrations")
    (Attribute "_calibrations")
    (Type "LinkVstr<arCCDCalibration>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_caretakers"
    (Name "_caretakers")
    (Attribute "_caretakers")
    (Type "VIList<arPerson>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_clockRate"
    (Name "_clockRate")
    (Attribute "_clockRate")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_col"
    (Name "_col")
    (Attribute "_col")
    (Type "arFloatErr")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_col1"
    (Name "_col1")
    (Attribute "_col1")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_colBinning"
    (Name "_colBinning")
    (Attribute "_colBinning")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_colWidth"
    (Name "_colWidth")
    (Attribute "_colWidth")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_comment"
    (Name "_comment")
    (Attribute "_comment")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_coord"
    (Name "_coord")
    (Attribute "_coord")
    (Type "arEquatorialCoord")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_counts"
    (Name "_counts")
    (Attribute "_counts")
    (Type "arFloatErr")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_creationTime"
    (Name "_creationTime")
    (Attribute "_creationTime")
    (Type "VTime")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_darkTime"
    (Name "_darkTime")
    (Attribute "_darkTime")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_daStars"
    (Name "_daStars")
    (Attribute "_daStars")
    (Type "VEIDictionary<o_u4b, VIArray < VIList < arDAStar > >>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_description"
    (Name "_description")
    (Attribute "_description")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_email"
    (Name "_email")
    (Attribute "_email")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_equinox"
    (Name "_equinox")
    (Attribute "_equinox")
    (Type "o_double")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_exposures"
    (Name "_exposures")
    (Attribute "_exposures")
    (Type "LinkVstr<arExposure>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_expTime"
    (Name "_expTime")
    (Attribute "_expTime")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_fax"
    (Name "_fax")
    (Attribute "_fax")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_firstName"
    (Name "_firstName")
    (Attribute "_firstName")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_frameSets"
    (Name "_frameSets")
    (Attribute "_frameSets")
    (Type "LinkVstr<arFrameSet>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_frameSetse"
    (Name "_frameSetse")
    (Attribute "_frameSets")
    (Type "LinkVstr<arFrameSet>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_greatCircleIncl"
    (Name "_greatCircleIncl")
    (Attribute "_greatCircleIncl")
    (Type "o_double")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_id"
    (Name "_id")
    (Attribute "_id")
    (Type "o_u4b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_lastName"
    (Name "_lastName")
    (Attribute "_lastName")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_lat"
    (Name "_lat")
    (Attribute "_lat")
    (Type "o_double")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_long"
    (Name "_long")
    (Attribute "_long")
    (Type "o_double")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_name"
    (Name "_name")
    (Attribute "_name")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_nCols"
    (Name "_nCols")
    (Attribute "_nCols")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_nRows"
    (Name "_nRows")
    (Attribute "_nRows")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_objectLink"
    (Name "_objectLink")
    (Key_Number "0")
  )

  (Attribute "_objectParameters"
    (Name "_objectParameters")
    (Attribute "_objectParameters")
    (Type "VVIDictionary<VString, PObject>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_obsReport"
    (Name "_obsReport")
    (Attribute "_obsReport")
    (Type "Link<arReport>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_overscan"
    (Name "_overscan")
    (Attribute "_overscan")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_phone"
    (Name "_phone")
    (Attribute "_phone")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_planEntry"
    (Name "_planEntry")
    (Attribute "_planEntry")
    (Type "Link<arPlanEntry>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_prescan"
    (Name "_prescan")
    (Attribute "_prescan")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_products"
    (Name "_products")
    (Attribute "_products")
    (Type "BiLinkVstr<arProduct>")
    (Key_Number "0")
  )

  (Attribute "_pses"
    (Name "_pses")
    (Attribute "_psets")
    (Type "LinkVstr<arPset>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_psetClass"
    (Name "_psetClass")
    (Attribute "_psetClass")
    (Type "BiLink<arPsetClass>")
    (Key_Number "0")
  )

  (Attribute "_psets"
    (Name "_psets")
    (Attribute "_psets")
    (Type "BiLinkVstr<arPset>")
    (Key_Number "0")
  )

  (Attribute "_psts"
    (Name "_psts")
    (Attribute "_psets")
    (Type "LinkVstr<arPset>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_quality"
    (Name "_quality")
    (Attribute "_quality")
    (Type "arDataQuality")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_reationTime"
    (Name "_reationTime")
    (Attribute "_creationTime")
    (Type "VTime")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_report"
    (Name "_report")
    (Attribute "_report")
    (Type "BiLink<arReport>")
    (Key_Number "0")
  )

  (Attribute "_rotAngle"
    (Name "_rotAngle")
    (Attribute "_rotAngle")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_row"
    (Name "_row")
    (Attribute "_row")
    (Type "arFloatErr")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_row1"
    (Name "_row1")
    (Attribute "_row1")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_rowBinning"
    (Name "_rowBinning")
    (Attribute "_rowBinning")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_rowWidth"
    (Name "_rowWidth")
    (Attribute "_rowWidth")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_sidescan"
    (Name "_sidescan")
    (Attribute "_sidescan")
    (Type "o_u2b")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_starLists"
    (Name "_starLists")
    (Attribute "_starLists")
    (Type "LinkVstr<arMTInstrStarList>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_startTime"
    (Name "_startTime")
    (Attribute "_startTime")
    (Type "VTime")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_stringParameters"
    (Name "_stringParameters")
    (Attribute "_stringParameters")
    (Type "VVIDictionary<VString, VString>")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_target"
    (Name "_target")
    (Attribute "_target")
    (Type "LinkAny")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_value"
    (Name "_value")
    (Attribute "_value")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_variance"
    (Name "_variance")
    (Attribute "_variance")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_version"
    (Name "_version")
    (Attribute "_version")
    (Type "PString")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_widthCovariance"
    (Name "_widthCovariance")
    (Attribute "_widthCovariance")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_xBoreOffset"
    (Name "_xBoreOffset")
    (Attribute "_xBoreOffset")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "0")
  )

  (Attribute "_yBoreOffset"
    (Name "_yBoreOffset")
    (Attribute "_yBoreOffset")
    (Type "o_float")
    (Scope "PRIVATE")
    (Key_Number "3")
  )

  (Operation "addStars"
    (Name "addStars")
  )

  (Operation "addStars'"
    (Name "addStars'")
    (Description "Add a star list for a field in an overlap column.")
    (Category "MODIFIER")
    (Return_Type "void")
    (Formal_Parameters "uint16 field, const ooVArray(arDAStar)& l, const ooVArray(arDAStar)& t")
  )

  (Operation "addStars`"
    (Name "addStars`")
    (Operation "addStars")
    (Description "Add a star list for a field in an overlap column.")
    (Category "MODIFIER")
    (Return_Type "void")
    (Formal_Parameters "uint16 field, const ooVArray(arDAStar)& l, const ooVArray(arDAStar)& t")
  )

  (Operation "airmass"
    (Name "airmass")
  )

  (Operation "amplifierConfiguration"
    (Name "amplifierConfiguration")
  )

  (Operation "ampUsed"
    (Name "ampUsed")
  )

  (Operation "arDoubleErr(o_double value, o_float err=0)"
    (Name "arDoubleErr(o_double value, o_float err=0)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double value, o_float err=0")
  )

  (Operation "arEquatorialCoord"
    (Name "arEquatorialCoord")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double longitude, o_double latitude, o_double equinox")
  )

  (Operation "arEquatorialCoord(const arEquatorialCoord& other)"
    (Name "arEquatorialCoord(const arEquatorialCoord& other)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arEquatorialCoord& other")
  )

  (Operation "arEquatorialCoord(o_double longitude, o_double latitude, o_doubl"
    (Name "arEquatorialCoord(o_double longitude, o_double latitude, o_doubl")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double longitude, o_double latitude, o_double equinox")
  )

  (Operation "arEquatorialCoordd"
    (Name "arEquatorialCoordd")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double longitude, o_double latitude, o_double equinox")
  )

  (Operation "arExposure"
    (Name "arExposure")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_float expTime, o_float darkTime, const VTime& startTime, o_u2b col1, o_u2b nCols, o_u2b row1, o_u2b nRows, o_u2b colBinning, o")
  )

  (Operation "arFloatErr"
    (Name "arFloatErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double value")
  )

  (Operation "arFloatErr(const arFloatErr& other)"
    (Name "arFloatErr(const arFloatErr& other)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arFloatErr& other")
  )

  (Operation "arFloatErr(o_float value, o_float err=0)"
    (Name "arFloatErr(o_float value, o_float err=0)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_float value, o_float err=0")
  )

  (Operation "arFrameSet"
    (Name "arFrameSet")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const VTime& startTime, const arEquatorialCoord& coord, o_float rotAngle")
  )

  (Operation "arMTExposure"
    (Name "arMTExposure")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_float expTime, o_float darkTime, const VTime& startTime, o_u2b col1, o_u2b nCols, o_u2b row1, o_u2b nRows, o_u2b colBinning, o")
  )

  (Operation "arMTExposure(const arMTExposure& other)"
    (Name "arMTExposure(const arMTExposure& other)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arMTExposure& other")
  )

  (Operation "arMTExposure(o_float expTime, o_float darkTime, const VTime& sta"
    (Name "arMTExposure(o_float expTime, o_float darkTime, const VTime& sta")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_float expTime, o_float darkTime, const VTime& startTime, o_u2b col1, o_u2b nCols, o_u2b row1, o_u2b nRows, o_u2b colBinning, o")
  )

  (Operation "arMTPipelineRun"
    (Name "arMTPipelineRun")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arReport* obsReport, const LinkVstr < arMTInstrStarList >& starLists, const LinkVstr < arCCDCalibration >& calibrations, c")
  )

  (Operation "arMTSequence(arMTSequenceFlavor flavor, arDataQuality quality, c"
    (Name "arMTSequence(arMTSequenceFlavor flavor, arDataQuality quality, c")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "arMTSequenceFlavor flavor, arDataQuality quality, const LinkVstr < arExposure >& exposures, const PObject* target, const arPlanE")
  )

  (Operation "arPerson"
    (Name "arPerson")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const char* lastName, const char* firstName, const char* email, const char* phone, const char* fax")
  )

  (Operation "arPerson'"
    (Name "arPerson'")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arPerson& other")
  )

  (Operation "arPerson(const arPerson& other)"
    (Name "arPerson(const arPerson& other)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arPerson& other")
  )

  (Operation "arPerson(const char* lastName, const char* firstName, const char"
    (Name "arPerson(const char* lastName, const char* firstName, const char")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const char* lastName, const char* firstName, const char* email, const char* phone, const char* fax")
  )

  (Operation "arPersonX"
    (Name "arPersonX")
    (Description "Copy constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arPerson& other")
  )

  (Operation "arProduct"
    (Name "arProduct")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arPlanEntry* planEntry=0")
  )

  (Operation "arPset"
    (Name "arPset")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "arPsetClass"
    (Name "arPsetClass")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const char* name, const char* version, const char* description, const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "arReport"
    (Name "arReport")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arAction* action, const LinkVstr < arPset >& psets, const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "arReport(const arAction* action, const LinkVstr < arPset >& pset"
    (Name "arReport(const arAction* action, const LinkVstr < arPset >& pset")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arAction* action, const LinkVstr < arPset >& psets, const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "arRun"
    (Name "arRun")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_u4b id, arRunFlavor flavor, o_double greatCircleIncl, o_double ascendingNode, o_double equinox, arGCSystem system, o_float xBo")
  )

  (Operation "arSeqence"
    (Name "arSeqence")
    (Source "basicSch/include/arSequence.cpp")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "arDataQuality quality, const LinkVstr < arExposure >& exposures, const PObject* target, const arPlanEntry* planEntry=0")
  )

  (Operation "arSeqence(arDataQuality quality, const LinkVstr < arExposure >&"
    (Name "arSeqence(arDataQuality quality, const LinkVstr < arExposure >&")
    (Source "basicSch/include/arSequence.cpp")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "arDataQuality quality, const LinkVstr < arExposure >& exposures, const PObject* target, const arPlanEntry* planEntry=0")
  )

  (Operation "arSequence(arDataQuality quality, const LinkVstr < arExposure >&"
    (Name "arSequence(arDataQuality quality, const LinkVstr < arExposure >&")
    (Source "/usrdevel/s1/munn/basicSch/include/arSequence.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "arDataQuality quality, const LinkVstr < arExposure >& exposures, const PObject* target, const arPlanEntry* planEntry=0")
  )

  (Operation "arSphericalCoord(const arSphericalCoord& other)"
    (Name "arSphericalCoord(const arSphericalCoord& other)")
    (Operation "arSphericalCoord")
    (Source "arSphericalCoord.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arSphericalCoord& other")
  )

  (Operation "arSphericalCoord(o_double longitude, o_double latitude)"
    (Name "arSphericalCoord(o_double longitude, o_double latitude)")
    (Operation "arSphericalCoord")
    (Source "arSphericalCoord.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double longitude, o_double latitude")
  )

  (Operation "arStamp"
    (Name "arStamp")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
  )

  (Operation "arStamp'"
    (Name "arStamp'")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "arStamp''"
    (Name "arStamp''")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const VTime& time, const char* comment=")
  )

  (Operation "arStamp'''"
    (Name "arStamp'''")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arStamp& other")
  )

  (Operation "arStamp(const arStamp& other)"
    (Name "arStamp(const arStamp& other)")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arStamp& other")
  )

  (Operation "arStamp(const LinkVstr < arPerson >& authors, const char* commen"
    (Name "arStamp(const LinkVstr < arPerson >& authors, const char* commen")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "arStamp(const LinkVstr < arPerson >& authors, const VTime& time,"
    (Name "arStamp(const LinkVstr < arPerson >& authors, const VTime& time,")
    (Operation "arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const VTime& time, const char* comment=")
  )

  (Operation "ascendingNode"
    (Name "ascendingNode")
    (Operation "ascendingNode")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "authors"
    (Name "authors")
    (Operation "authors")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Return_Type "LinkVstr<arPerson>&")
    (Constant "TRUE")
  )

  (Operation "c"
    (Name "c")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )

  (Operation "c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )

  (Operation "c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )

  (Operation "c2"
    (Name "c2")
    (Operation "arStamp")
    (Description "Construct a time stamp for the specified time.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const CHAIN* authors, const sdbTime& time, const char* comment = \"\"")
  )

  (Operation "c3"
    (Name "c3")
    (Operation "arStamp")
    (Description "Construct a NULL time stamp.")
    (Category "CONSTRUCTOR")
  )

  (Operation "c4"
    (Name "c4")
    (Operation "arStamp")
    (Description "Copy constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arStamp& other")
  )

  (Operation "camRow"
    (Name "camRow")
    (Description "Row in the imaging camera of the CCD which took this frame.")
    (Return_Type "uint8")
    (Inline "TRUE")
  )

  (Operation "caretaker"
    (Name "caretaker")
    (Operation "caretaker")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Return_Type "arPerson&")
    (Formal_Parameters "o_u4b position")
    (Constant "TRUE")
  )

  (Operation "classification"
    (Name "classification")
  )

  (Operation "coefficient"
    (Name "coefficient")
    (Description "Return the value of the specified coefficient at the given time, using the specified interpolation schema.")
    (Return_Type "arFloatErr")
    (Formal_Parameters "arMTCoefficient coefficient, const sdbTime& time, arMTInterpolation interp")
    (Constant "TRUE")
  )

  (Operation "col"
    (Name "col")
    (Operation "col")
    (Source "/usrdevel/s1/munn/photoSch/include/arDAStar.h")
    (Inline "TRUE")
  )

  (Operation "col1"
    (Name "col1")
    (Operation "col1")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "colBinning"
    (Name "colBinning")
    (Operation "colBinning")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "colBinningc"
    (Name "colBinningc")
    (Operation "colBinning")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "colWidth"
    (Name "colWidth")
    (Operation "colWidth")
    (Source "/usrdevel/s1/munn/photoSch/include/arDAStar.h")
    (Inline "TRUE")
  )

  (Operation "comment"
    (Name "comment")
    (Operation "comment")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "coord"
    (Name "coord")
    (Operation "coord")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Return_Type "arEquatorialCoord&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "cos"
    (Name "cos")
    (Operation "cos")
    (Source "/usrdevel/s1/munn/basicSch/include/arDoubleErr.h")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )

  (Operation "counts"
    (Name "counts")
    (Operation "counts")
    (Source "/usrdevel/s1/munn/photoSch/include/arDAStar.h")
    (Inline "TRUE")
  )

  (Operation "created"
    (Name "created")
    (Operation "created")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Return_Type "arStamp&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "creationStamp"
    (Name "creationStamp")
    (Operation "creationStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "arStamp&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "creationStap"
    (Name "creationStap")
    (Operation "creationStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Return_Type "arStamp&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "creationTime"
    (Name "creationTime")
    (Operation "creationTime")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Return_Type "VTime&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "darkTime"
    (Name "darkTime")
    (Operation "darkTime")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "daStars"
    (Name "daStars")
    (Operation "daStars")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Formal_Parameters "o_u1b ccd, o_u4b frame")
  )

  (Operation "decInDegrees"
    (Name "decInDegrees")
    (Operation "decInDegrees")
    (Source "arSphericalCoord.h")
    (Inline "TRUE")
  )

  (Operation "defaultPsets"
    (Name "defaultPsets")
    (Operation "defaultPsets")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Return_Type "LinkVstr<arPset>&")
    (Constant "TRUE")
  )

  (Operation "deleteCaretaker"
    (Name "deleteCaretaker")
    (Operation "deleteCaretaker")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Formal_Parameters "o_u4b position")
    (Inline "TRUE")
  )

  (Operation "Description"
    (Name "Description")
    (Operation "description")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "distance"
    (Name "distance")
    (Operation "distance")
    (Source "arSphericalCoord.h")
    (Formal_Parameters "const arSphericalCoord& other")
  )

  (Operation "email"
    (Name "email")
    (Operation "email")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "endTime"
    (Name "endTime")
    (Description "Return the end of the time bracket over which this is valid.")
    (Return_Type "sdbTime")
  )

  (Operation "equinox"
    (Name "equinox")
    (Operation "equinox")
    (Source "arEquatorialCoord.h")
    (Inline "TRUE")
  )

  (Operation "err"
    (Name "err")
    (Operation "err")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Inline "TRUE")
  )

  (Operation "exp"
    (Name "exp")
    (Operation "exp")
    (Source "/usrdevel/s1/munn/basicSch/include/arDoubleErr.h")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )

  (Operation "Exposure"
    (Name "Exposure")
    (Operation "arExposure")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_float expTime, o_float darkTime, const sdbTime& startTime o_u2b col1, o_u2b nCols, o_u2b row1, o_u2b nRows, o_u2b colBinning, ")
  )

  (Operation "exposures"
    (Name "exposures")
    (Operation "exposures")
    (Source "/usrdevel/s1/munn/basicSch/include/arSequence.h")
    (Return_Type "LinkVstr<arExposure>&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "expTime"
    (Name "expTime")
    (Operation "expTime")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "fax"
    (Name "fax")
    (Operation "fax")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "filter"
    (Name "filter")
    (Operation "filter")
    (Source "/usrdevel/s1/munn/mtSch/include/arMTExposure.h")
    (Inline "TRUE")
  )

  (Operation "Find"
    (Name "Find")
    (Operation "Find")
    (Source "/usrdevel/s1/munn/basicSch/include/arSequence.h")
    (Return_Type "arSequence*")
    (Formal_Parameters "const char* name")
    (Static "TRUE")
    (Constant "TRUE")
  )

  (Operation "Find'"
    (Name "Find'")
    (Operation "Find")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Return_Type "LinkVstr<arReport>")
    (Formal_Parameters "arAction* action, o_bool unreviewedOnly=TRUE")
    (Static "TRUE")
  )

  (Operation "Find(arAction* action, const VDate& creationDate, o_bool unrevie"
    (Name "Find(arAction* action, const VDate& creationDate, o_bool unrevie")
    (Operation "Find")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Return_Type "LinkVstr<arReport>")
    (Formal_Parameters "arAction* action, const VDate& creationDate, o_bool unreviewedOnly=TRUE")
    (Static "TRUE")
  )

  (Operation "Find(arAction* action, o_bool unreviewedOnly=TRUE)"
    (Name "Find(arAction* action, o_bool unreviewedOnly=TRUE)")
    (Operation "Find")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Return_Type "LinkVstr<arReport>")
    (Formal_Parameters "arAction* action, o_bool unreviewedOnly=TRUE")
    (Static "TRUE")
  )

  (Operation "FindAllVersions"
    (Name "FindAllVersions")
    (Operation "FindAllVersions")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "LinkVstr<arPsetClass>")
    (Formal_Parameters "const char* name")
    (Static "TRUE")
  )

  (Operation "FindOne"
    (Name "FindOne")
    (Operation "FindOne")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Return_Type "arPerson*")
    (Formal_Parameters "const char* lastName, const char* firstName=")
    (Static "TRUE")
  )

  (Operation "firstName"
    (Name "firstName")
    (Operation "firstName")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "flavor"
    (Name "flavor")
    (Operation "flavor")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "frameSets"
    (Name "frameSets")
    (Operation "frameSets")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Return_Type "LinkVstr<arFrameSet>&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "freeze"
    (Name "freeze")
    (Operation "freeze")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
  )

  (Operation "getObjectParameter"
    (Name "getObjectParameter")
    (Operation "getObjectParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "PObject&")
    (Formal_Parameters "const char* name")
    (Constant "TRUE")
  )

  (Operation "getObjectParameterNames"
    (Name "getObjectParameterNames")
    (Operation "getObjectParameterNames")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
  )

  (Operation "getObjectValue"
    (Name "getObjectValue")
    (Description "Return the value of an object parameter.")
    (Return_Type "const ooHandle(ooObj)&")
    (Formal_Parameters "const ooHandle(arParameter)& parameter")
    (Constant "TRUE")
  )

  (Operation "getStringParameter"
    (Name "getStringParameter")
    (Operation "getStringParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "char*")
    (Formal_Parameters "const char* name")
    (Constant "TRUE")
  )

  (Operation "getStringParameterNames"
    (Name "getStringParameterNames")
    (Operation "getStringParameterNames")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
  )

  (Operation "getStringValue"
    (Name "getStringValue")
    (Description "Return the value for the specified string parameter.")
    (Return_Type "const char*")
    (Formal_Parameters "const ooHandle(arParameter)& parameter")
    (Constant "TRUE")
  )

  (Operation "greatCircleIncl"
    (Name "greatCircleIncl")
    (Operation "greatCircleIncl")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "id"
    (Name "id")
    (Operation "id")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "insertCaretaker"
    (Name "insertCaretaker")
    (Operation "insertCaretaker")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Formal_Parameters "o_u4b position, const arPerson& person")
    (Inline "TRUE")
  )

  (Operation "isReviewed"
    (Name "isReviewed")
    (Operation "isReviewed")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Inline "TRUE")
  )

  (Operation "lastName"
    (Name "lastName")
    (Operation "lastName")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "latitude"
    (Name "latitude")
    (Operation "latitude")
    (Source "arSphericalCoord.h")
    (Inline "TRUE")
  )

  (Operation "latitudeInRadians"
    (Name "latitudeInRadians")
    (Operation "latitudeInRadians")
    (Source "arSphericalCoord.h")
    (Inline "TRUE")
  )

  (Operation "log"
    (Name "log")
    (Operation "log")
    (Source "/usrdevel/s1/munn/basicSch/include/arDoubleErr.h")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )

  (Operation "longitude"
    (Name "longitude")
    (Operation "longitude")
    (Source "arSphericalCoord.h")
    (Inline "TRUE")
  )

  (Operation "longitudeInRadians"
    (Name "longitudeInRadians")
    (Operation "longitudeInRadians")
    (Source "arSphericalCoord.h")
    (Inline "TRUE")
  )

  (Operation "makeDefault"
    (Name "makeDefault")
    (Operation "makeDefault")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
  )

  (Operation "merged = 1"
    (Name "merged = 1")
  )

  (Operation "Name"
    (Name "Name")
    (Operation "name")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Type "VIRTUAL")
    (Return_Type "char*")
    (Constant "TRUE")
  )

  (Operation "nCaretakers"
    (Name "nCaretakers")
    (Operation "nCaretakers")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Inline "TRUE")
  )

  (Operation "nCols"
    (Name "nCols")
    (Operation "nCols")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "newVersion"
    (Name "newVersion")
    (Operation "newVersion")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Formal_Parameters "const char* version, const char* description, const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "nFields"
    (Name "nFields")
  )

  (Operation "nRows"
    (Name "nRows")
    (Operation "nRows")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "null"
    (Name "null")
    (Operation "null")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Inline "TRUE")
  )

  (Operation "obsReport"
    (Name "obsReport")
    (Operation "obsReport")
    (Source "/usrdevel/s1/munn/mtSch/include/arMTPipelineRun.h")
    (Return_Type "arReport*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "operator *"
    (Name "operator *")
    (Operation "operator *")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )

  (Operation "operator *="
    (Name "operator *=")
    (Operation "operator *=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr other")
    (Inline "TRUE")
  )

  (Operation "operator +"
    (Name "operator +")
    (Operation "operator +")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )

  (Operation "operator +="
    (Name "operator +=")
    (Operation "operator +=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr other")
    (Inline "TRUE")
  )

  (Operation "operator -"
    (Name "operator -")
    (Operation "operator -")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )

  (Operation "operator -="
    (Name "operator -=")
    (Operation "operator -=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr other")
    (Inline "TRUE")
  )

  (Operation "operator /"
    (Name "operator /")
    (Operation "operator /")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )

  (Operation "operator /="
    (Name "operator /=")
    (Operation "operator /=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "arFloatErr other")
    (Inline "TRUE")
  )

  (Operation "operator <<"
    (Name "operator <<")
    (Operation "operator <<")
    (Source "arSphericalCoord.h")
    (Formal_Parameters "ostream& s, const arSphericalCoord& coord")
    (Friend "TRUE")
  )

  (Operation "operator ^"
    (Name "operator ^")
    (Operation "operator ^")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "o_float other")
    (Inline "TRUE")
  )

  (Operation "operator ^(o_4b other)"
    (Name "operator ^(o_4b other)")
    (Operation "operator ^")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "o_4b other")
  )

  (Operation "operator ^(o_float other)"
    (Name "operator ^(o_float other)")
    (Operation "operator ^")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "o_float other")
  )

  (Operation "operator ^="
    (Name "operator ^=")
    (Operation "operator ^=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "o_float other")
    (Inline "TRUE")
  )

  (Operation "operator ^=(o_4b other)"
    (Name "operator ^=(o_4b other)")
    (Operation "operator ^=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "o_4b other")
  )

  (Operation "operator ^=(o_float other)"
    (Name "operator ^=(o_float other)")
    (Operation "operator ^=")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Formal_Parameters "o_float other")
  )

  (Operation "operator<<"
    (Name "operator<<")
    (Operation "operator<<")
    (Source "arExposure.cpp")
    (Formal_Parameters "ostream& s, const arExposure& exposure")
    (Friend "TRUE")
  )

  (Operation "overscan"
    (Name "overscan")
    (Operation "overscan")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "phone"
    (Name "phone")
    (Operation "phone")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "positionAngle"
    (Name "positionAngle")
    (Operation "positionAngle")
    (Source "arSphericalCoord.h")
    (Formal_Parameters "const arSphericalCoord& other")
  )

  (Operation "precess"
    (Name "precess")
    (Operation "precess")
    (Source "arEquatorialCoord.h")
    (Formal_Parameters "o_double equinox")
  )

  (Operation "prescan"
    (Name "prescan")
    (Operation "prescan")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "products"
    (Name "products")
    (Operation "products")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Return_Type "LinkVstr<arProduct>")
    (Constant "TRUE")
  )

  (Operation "psetClass"
    (Name "psetClass")
    (Operation "psetClass")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPset.h")
    (Return_Type "arPsetClass*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "psets"
    (Name "psets")
    (Operation "psets")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "LinkVstr<arPset>")
    (Constant "TRUE")
  )

  (Operation "quality"
    (Name "quality")
    (Operation "quality")
    (Source "/usrdevel/s1/munn/basicSch/include/arSequence.h")
    (Inline "TRUE")
  )

  (Operation "raInHours"
    (Name "raInHours")
    (Operation "raInHours")
    (Source "arSphericalCoord.h")
    (Inline "TRUE")
  )

  (Operation "removeObjectParameter"
    (Name "removeObjectParameter")
    (Operation "removeObjectParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Formal_Parameters "const char* name")
  )

  (Operation "removeStringParameter"
    (Name "removeStringParameter")
    (Operation "removeStringParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Formal_Parameters "const char* name")
  )

  (Operation "replaceCaretaker"
    (Name "replaceCaretaker")
    (Operation "replaceCaretaker")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Formal_Parameters "o_u4b position, const arPerson& person")
    (Inline "TRUE")
  )

  (Operation "replaceObjectParameter"
    (Name "replaceObjectParameter")
    (Operation "replaceObjectParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Formal_Parameters "const char* name, const char* description")
  )

  (Operation "replaceStringParameter"
    (Name "replaceStringParameter")
    (Operation "replaceStringParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Formal_Parameters "const char* name, const char* description")
  )

  (Operation "report"
    (Name "report")
    (Operation "report")
    (Source "/home/s1/munn/pp/adminSch/include/arProduct.h")
    (Return_Type "arReport*")
    (Constant "TRUE")
  )

  (Operation "reset"
    (Name "reset")
    (Operation "reset")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "review"
    (Name "review")
    (Operation "review")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Formal_Parameters "const LinkVstr < arPerson >& authors, const char* comment=")
  )

  (Operation "reviewed"
    (Name "reviewed")
    (Operation "reviewed")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Return_Type "arStamp&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "rotAngle"
    (Name "rotAngle")
    (Operation "rotAngle")
    (Source "/usrdevel/s1/munn/photoSch/include/arFrameSet.h")
    (Inline "TRUE")
  )

  (Operation "row"
    (Name "row")
    (Operation "row")
    (Source "/usrdevel/s1/munn/photoSch/include/arDAStar.h")
    (Inline "TRUE")
  )

  (Operation "row1"
    (Name "row1")
    (Operation "row1")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "rowBinning"
    (Name "rowBinning")
    (Operation "rowBinning")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "rowBnning"
    (Name "rowBnning")
    (Operation "rowBinning")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "rowWidth"
    (Name "rowWidth")
    (Operation "rowWidth")
    (Source "/usrdevel/s1/munn/photoSch/include/arDAStar.h")
    (Inline "TRUE")
  )

  (Operation "set"
    (Name "set")
    (Operation "set")
    (Source "arSphericalCoord.h")
    (Formal_Parameters "o_double longitude, o_double latitude")
    (Inline "TRUE")
  )

  (Operation "set matches"
    (Name "set matches")
  )

  (Operation "set matches = NULL"
    (Name "set matches = NULL")
  )

  (Operation "set merged = FALSE"
    (Name "set merged = FALSE")
  )

  (Operation "set merged = TRUE"
    (Name "set merged = TRUE")
  )

  (Operation "set mergeRun"
    (Name "set mergeRun")
  )

  (Operation "set mergeRun = NULL"
    (Name "set mergeRun = NULL")
  )

  (Operation "set selectedFieldList"
    (Name "set selectedFieldList")
  )

  (Operation "set selectedFieldList = NULL"
    (Name "set selectedFieldList = NULL")
  )

  (Operation "set status"
    (Name "set status")
  )

  (Operation "set status = FIRST"
    (Name "set status = FIRST")
  )

  (Operation "set status = PRIMARY"
    (Name "set status = PRIMARY")
  )

  (Operation "set status = REPEAT"
    (Name "set status = REPEAT")
  )

  (Operation "set status = SECONDARY"
    (Name "set status = SECONDARY")
  )

  (Operation "set status = UNDETERMINED"
    (Name "set status = UNDETERMINED")
  )

  (Operation "set target"
    (Name "set target")
  )

  (Operation "set target = NULL"
    (Name "set target = NULL")
  )

  (Operation "set targetList"
    (Name "set targetList")
  )

  (Operation "set targetList = NULL"
    (Name "set targetList = NULL")
  )

  (Operation "setCCD"
    (Name "setCCD")
    (Operation "setCCD")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Formal_Parameters "o_u1b ccd, o_bool amp0Used, o_bool amp1Used, o_bool amp2Used, o_bool amp3Used")
    (Inline "TRUE")
  )

  (Operation "setEmail"
    (Name "setEmail")
    (Operation "setEmail")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Formal_Parameters "const char* email")
    (Inline "TRUE")
  )

  (Operation "setEquinox"
    (Name "setEquinox")
    (Operation "setEquinox")
    (Source "arEquatorialCoord.h")
    (Formal_Parameters "o_double equinox")
    (Inline "TRUE")
  )

  (Operation "setFax"
    (Name "setFax")
    (Operation "setFax")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Formal_Parameters "const char* fax")
    (Inline "TRUE")
  )

  (Operation "setFirstName"
    (Name "setFirstName")
    (Operation "setFirstName")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Formal_Parameters "const char* firstName")
    (Inline "TRUE")
  )

  (Operation "setInHoursAndDegrees"
    (Name "setInHoursAndDegrees")
    (Operation "setInHoursAndDegrees")
    (Source "arSphericalCoord.h")
    (Formal_Parameters "o_double ra, o_double dec")
    (Inline "TRUE")
  )

  (Operation "setInRadians"
    (Name "setInRadians")
    (Operation "setInRadians")
    (Source "arSphericalCoord.h")
    (Formal_Parameters "o_double longitude, o_double latitude")
    (Inline "TRUE")
  )

  (Operation "setLastName"
    (Name "setLastName")
    (Operation "setLastName")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Formal_Parameters "const char* lastName")
    (Inline "TRUE")
  )

  (Operation "setObjectParameter"
    (Name "setObjectParameter")
    (Operation "setObjectParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPset.h")
    (Formal_Parameters "const char* name, const PObject& value")
  )

  (Operation "setPhone"
    (Name "setPhone")
    (Operation "setPhone")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Formal_Parameters "const char* phone")
    (Inline "TRUE")
  )

  (Operation "setPone"
    (Name "setPone")
    (Operation "setPhone")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPerson.h")
    (Formal_Parameters "const char* phone")
    (Inline "TRUE")
  )

  (Operation "setPsetClass"
    (Name "setPsetClass")
    (Operation "setPsetClass")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPset.h")
    (Formal_Parameters "const arPsetClass* psetClass")
  )

  (Operation "setReport"
    (Name "setReport")
    (Operation "setReport")
    (Source "/home/s1/munn/pp/adminSch/include/arProduct.h")
    (Formal_Parameters "const arReport* report")
  )

  (Operation "setStringParameter"
    (Name "setStringParameter")
    (Operation "setStringParameter")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPset.h")
    (Formal_Parameters "const char* name, const char* value")
  )

  (Operation "sidescan"
    (Name "sidescan")
    (Operation "sidescan")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Inline "TRUE")
  )

  (Operation "sin"
    (Name "sin")
    (Operation "sin")
    (Source "/usrdevel/s1/munn/basicSch/include/arDoubleErr.h")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )

  (Operation "sln"
    (Name "sln")
    (Operation "sln")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Inline "TRUE")
  )

  (Operation "slog"
    (Name "slog")
    (Operation "slog")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Inline "TRUE")
  )

  (Operation "sqrt"
    (Name "sqrt")
    (Operation "sqrt")
    (Source "/usrdevel/s1/munn/basicSch/include/arDoubleErr.h")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )

  (Operation "starLists"
    (Name "starLists")
    (Operation "starLists")
    (Source "/usrdevel/s1/munn/mtSch/include/arMTPipelineRun.h")
    (Return_Type "LinkVstr<arMTInstrStarList>&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "stars"
    (Name "stars")
  )

  (Operation "startTime"
    (Name "startTime")
    (Operation "startTime")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Return_Type "VTime&")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "system"
    (Name "system")
    (Operation "system")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "tan"
    (Name "tan")
    (Operation "tan")
    (Source "/usrdevel/s1/munn/basicSch/include/arDoubleErr.h")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )

  (Operation "target"
    (Name "target")
    (Operation "target")
    (Source "/usrdevel/s1/munn/basicSch/include/arSequence.h")
    (Return_Type "PObject*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "tcc"
    (Name "tcc")
    (Description "Return the TCC info for the specified field.")
    (Return_Type "arTCCInfo&")
    (Constant "TRUE")
  )

  (Operation "test"
    (Name "test")
    (Description "junk")
    (Return_Type "uint8")
    (Formal_Parameters "uint8 hi")
  )

  (Operation "TimeStamp"
    (Name "TimeStamp")
    (Operation "arStamp")
    (Description "Construct a NULL time stamp.")
    (Category "CONSTRUCTOR")
  )

  (Operation "TimeStamp'"
    (Name "TimeStamp'")
    (Operation "arStamp")
    (Description "Construct a time stamp for now.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr <arPerson>& authors, const char* comment = \"\"")
  )

  (Operation "TimeStamp''"
    (Name "TimeStamp''")
    (Operation "arStamp")
    (Description "Construct a time stamp for the specified time.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LinkVstr <arPerson>& authors, const sdbTime& time, const char* comment = \"\"")
  )

  (Operation "TimeStamp'''"
    (Name "TimeStamp'''")
    (Operation "arStamp")
    (Description "Copy constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arStamp& other")
  )

  (Operation "trans"
    (Name "trans")
    (Description "Return the astrometric transformation for the specified filter in the specified field.")
    (Return_Type "const arTrans&")
    (Formal_Parameters "uint16 field, char filter")
    (Constant "TRUE")
  )

  (Operation "validCCD"
    (Name "validCCD")
    (Operation "validCCD")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Formal_Parameters "o_u1b ccd")
    (Inline "TRUE")
  )

  (Operation "value"
    (Name "value")
    (Operation "value")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Inline "TRUE")
  )

  (Operation "variance"
    (Name "variance")
    (Operation "variance")
    (Source "/usrdevel/s1/munn/basicSch/include/arFloatErr.h")
    (Inline "TRUE")
  )

  (Operation "version"
    (Name "version")
    (Operation "version")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arPsetClass.h")
    (Return_Type "char*")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "widthCovariance"
    (Name "widthCovariance")
    (Operation "widthCovariance")
    (Source "/usrdevel/s1/munn/photoSch/include/arDAStar.h")
    (Inline "TRUE")
  )

  (Operation "x"
    (Name "x")
    (Description "Return the x position of the star in pixels.")
    (Return_Type "float32")
    (Constant "TRUE")
  )

  (Operation "xBoreOffset"
    (Name "xBoreOffset")
    (Operation "xBoreOffset")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "y"
    (Name "y")
    (Description "Return the y position in pixels.")
    (Return_Type "float32")
    (Constant "TRUE")
    (Inline "TRUE")
  )

  (Operation "yBoreOffset"
    (Name "yBoreOffset")
    (Operation "yBoreOffset")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Inline "TRUE")
  )

  (Operation "zenithDistance"
    (Name "zenithDistance")
    (Operation "zenithDistance")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Formal_Parameters "o_double longitude=105.82000, o_double latitude=32.78056")
  )

  (Operation "^'"
    (Name "^'")
    (Operation "operator ^")
    (Return_Type "arFloatErr")
    (Formal_Parameters "o_4b other")
  )

  (Operation "^''"
    (Name "^''")
    (Operation "operator ^")
    (Return_Type "arFLoatErr")
    (Formal_Parameters "o_float other")
  )

  (Operation "^(o_4b other)"
    (Name "^(o_4b other)")
    (Operation "operator ^")
    (Return_Type "arFloatErr")
    (Formal_Parameters "o_4b other")
  )

  (Operation "^="
    (Name "^=")
    (Operation "operator ^=")
    (Category "MODIFIER")
    (Return_Type "arFLoatErr&")
    (Formal_Parameters "o_float other")
  )

  (Operation "^='"
    (Name "^='")
    (Operation "operator ^=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "o_4b other")
  )

  (Operation "^=''"
    (Name "^=''")
    (Operation "operator ^=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "o_float other")
  )

  (Operation "^=(o_4b other)"
    (Name "^=(o_4b other)")
    (Operation "operator ^=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "o_4b other")
  )

  (Operation "^=(o_float other)"
    (Name "^=(o_float other)")
    (Operation "operator ^=")
    (Category "MODIFIER")
    (Return_Type "arFLoatErr&")
    (Formal_Parameters "o_float other")
  )

  (Operation "~"
    (Name "~")
    (Description "Destructor.")
    (Category "DESTRUCTOR")
  )

  (Operation "~andleOperation"
    (Name "~andleOperation")
    (Description "Destructor.")
    (Category "DESTRUCTOR")
  )

  (Operation "~arAction"
    (Name "~arAction")
    (Operation "~arAction")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arAction.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arExposure"
    (Name "~arExposure")
    (Operation "~arExposure")
    (Source "/usrdevel/s1/munn/basicSch/include/arExposure.h")
    (Type "VIRTUAL")
    (Category "DESTRUCTOR")
  )

  (Operation "~arMTExposure"
    (Name "~arMTExposure")
    (Operation "~arMTExposure")
    (Source "/usrdevel/s1/munn/mtSch/include/arMTExposure.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arMTPipelineRun"
    (Name "~arMTPipelineRun")
    (Operation "~arMTPipelineRun")
    (Source "/usrdevel/s1/munn/mtSch/include/arMTPipelineRun.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arMTSequence"
    (Name "~arMTSequence")
    (Operation "~arMTSequence")
    (Source "/usrdevel/s1/munn/mtSch/include/arMTSequence.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arProduct"
    (Name "~arProduct")
    (Operation "~arProduct")
    (Source "/home/s1/munn/pp/adminSch/include/arProduct.h")
    (Type "VIRTUAL")
    (Category "DESTRUCTOR")
  )

  (Operation "~arReport"
    (Name "~arReport")
    (Operation "~arReport")
    (Source "/home/s1/munn/pp/adminSch/include/arReport.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arRun"
    (Name "~arRun")
    (Operation "~arRun")
    (Source "/usrdevel/s1/munn/photoSch/include/arRun.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arSequence"
    (Name "~arSequence")
    (Operation "~arSequence")
    (Source "/usrdevel/s1/munn/basicSch/include/arSequence.h")
    (Category "DESTRUCTOR")
  )

  (Operation "~arStamp"
    (Name "~arStamp")
    (Operation "~arStamp")
    (Source "/tmp_mnt/home/s1/munn/adminSch/include/arStamp.h")
    (Category "DESTRUCTOR")
  )

  (Association "1"
    (Name "1")
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
  )

  (Association "author"
    (Name "author")
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )

  (Association "authors"
    (Name "authors")
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
    (Container2 "LinkVstr")
  )

  (Association "caretaker"
    (Name "caretaker")
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
    (Container2 "LinkVstr")
  )

  (Association "caretakers"
    (Name "caretakers")
    (Multiplicity1 "ONE OR MORE")
    (Multiplicity2 "MANY")
  )

  (Association "defaults"
    (Name "defaults")
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
  )

  (Association "instantiates"
    (Name "instantiates")
    (Multiplicity2 "MANY")
    (Container1 "BiLink")
    (Container2 "BiLinkVstr")
  )

  (Association "old color terms"
    (Name "old color terms")
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
  )

  (Association "other runs"
    (Name "other runs")
  )

  (Association "uses"
    (Name "uses")
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
  )

  (Aggregation "										n"
    (Name "										n")
    (Multiplicity2 "MANY")
  )

  (Aggregation ""
    (Name "")
    (Multiplicity2 "MANY")
  )

  (Aggregation " 									n"
    (Name " 									n")
    (Multiplicity2 "MANY")
  )

  (Aggregation "a"
    (Name "a")
    (Role2 "created")
    (Static "TRUE")
    (Friend "TRUE")
  )

  (Aggregation "color terms"
    (Name "color terms")
    (Multiplicity2 "MANY")
  )

  (Aggregation "created"
    (Name "created")
    (Role2 "created")
    (Static "TRUE")
    (Friend "TRUE")
  )

  (Aggregation "deblend"
    (Name "deblend")
    (Multiplicity2 "MANY")
  )

  (Aggregation "extinction"
    (Name "extinction")
    (Multiplicity2 "ONE OR MORE")
  )

  (Aggregation "ql"
    (Name "ql")
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "5")
  )

  (Aggregation "review"
    (Name "review")
    (Multiplicity2 "MANY")
    (Static "TRUE")
    (Friend "TRUE")
  )

  (Aggregation "zero points"
    (Name "zero points")
    (Multiplicity2 "ONE OR MORE")
  )

  (Aggregation "_coord"
    (Name "_coord")
  )

  (Aggregation "_created"
    (Name "_created")
  )

  (Aggregation "_filter"
    (Name "_filter")
  )

  (Aggregation "_flavor"
    (Name "_flavor")
  )

  (Aggregation "_quality"
    (Name "_quality")
  )

  (Aggregation "_reviewed"
    (Name "_reviewed")
  )

  (Aggregation "_system"
    (Name "_system")
  )

  (Object "Excalibur Run Pset"
    (Name "Excalibur Run Pset")
    (Role "CONTROLLER")
  )

  (Subsystem "Administration"
    (Name "Administration")
  )

  (Subsystem "Astrometric Pipelines"
    (Name "Astrometric Pipelines")
  )

  (Subsystem "Drift Scan"
    (Name "Drift Scan")
  )

  (Subsystem "Drift Scan Run"
    (Name "Drift Scan Run")
  )

  (Subsystem "Frames Pipeline"
    (Name "Frames Pipeline")
  )

  (Subsystem "MT"
    (Name "MT")
  )

  (Subsystem "Postage Stamp Pipeline"
    (Name "Postage Stamp Pipeline")
  )

  (Subsystem "SSC Pipeline"
    (Name "SSC Pipeline")
  )

  (Process "AP Check In"
    (Name "AP Check In")
    (Type "GENERATION")
  )

  (Process "FP Check In"
    (Name "FP Check In")
    (Type "GENERATION")
    (Description "Check in the results of the frames pipeline to the database.")
  )

  (Process "Merge Objects"
    (Name "Merge Objects")
    (Type "TRANSFORMATION")
  )

  (Process "Set Status"
    (Name "Set Status")
    (Type "TRANSFORMATION")
  )

  (Process "Target"
    (Name "Target")
    (Type "GENERATION")
  )

  (Data_Store "Astrometric Calibrations"
    (Name "Astrometric Calibrations")
  )

  (Data_Store "Atlas Images"
    (Name "Atlas Images")
  )

  (Data_Store "Object Lists"
    (Name "Object Lists")
  )

  (Data_Store "Objects"
    (Name "Objects")
  )

  (Data_Store "Photometric Calibrations"
    (Name "Photometric Calibrations")
  )

  (Actor "Astrometric Pipeline"
    (Name "Astrometric Pipeline")
  )

  (Actor "Frames Pipeline"
    (Name "Frames Pipeline")
  )

  (Actor "Rich Kron"
    (Name "Rich Kron")
  )

  (State "FPR: Checked In"
    (Name "FPR: Checked In")
    (State "Frames Pipeline Run: Checked In")
    (Sequence_Number "0")
    (Type "CREATION")
    (Description "Check in a frames pipeline run to the database.")
  )

  (State "FPR: Merged"
    (Name "FPR: Merged")
    (State "Frames Pipeline Run: Merged")
    (Sequence_Number "0")
    (Type "FINAL")
    (Description "After merging its objects with other previously merged objects in the database.")
  )

  (State "O: Checked In"
    (Name "O: Checked In")
    (State "Object: Checkin In")
    (Sequence_Number "0")
    (Type "CREATION")
    (Description "Check in an object to the database.")
  )

  (State "O: Merged"
    (Name "O: Merged")
    (State "Object: Merged")
    (Sequence_Number "0")
    (Description "Object after merging with previously merged objects in the database.")
  )

  (State "O: Non-Repeat"
    (Name "O: Non-Repeat")
    (State "Object: First")
    (Sequence_Number "0")
    (Description "This is the first detection of an object within a run.")
  )

  (State "O: Primary"
    (Name "O: Primary")
    (State "Object: Primary")
    (Sequence_Number "0")
    (Description "Slected as a primary object.")
  )

  (State "O: Repeat"
    (Name "O: Repeat")
    (State "Object: Repeat")
    (Sequence_Number "0")
    (Type "FINAL")
    (Description "Object is a repeat of object detected in overlap region from the previous field in the run.")
  )

  (State "O: Secondary"
    (Name "O: Secondary")
    (State "Object: Secondary")
    (Sequence_Number "0")
    (Type "FINAL")
    (Description "Selected as a secondary object.")
  )

  (State "O: Selected"
    (Name "O: Selected")
    (State "Object: Selected")
    (Sequence_Number "0")
    (Description "After it has been through the selection process.")
  )

  (State "O: Targeted"
    (Name "O: Targeted")
    (State "Object: Targeted")
    (Sequence_Number "0")
    (Type "FINAL")
    (Description "After target selection.")
  )

  (State "OL: Checked In"
    (Name "OL: Checked In")
    (State "Object List: Checked In")
    (Sequence_Number "0")
    (Type "CREATION")
    (Description "Check in an object list to the database.")
  )

  (State "OL: Merged"
    (Name "OL: Merged")
    (State "Object List: Merged")
    (Sequence_Number "0")
    (Description "Object list after its members have been merged with previously merged objects in the database.")
  )

  (State "OL: Primary"
    (Name "OL: Primary")
    (State "Object List: Primary")
    (Sequence_Number "0")
    (Description "Selected as a primary object list.")
  )

  (State "OL: Secondary"
    (Name "OL: Secondary")
    (State "Object List: Secondary")
    (Sequence_Number "0")
    (Type "FINAL")
    (Description "Has been selected as a secondary object list.")
  )

  (State "OL: Selected"
    (Name "OL: Selected")
    (State "Object List: Selected")
    (Sequence_Number "0")
    (Description "After it has been through the selection process.")
  )

  (State "OL: Targeted"
    (Name "OL: Targeted")
    (State "Object List: Targeted")
    (Sequence_Number "0")
    (Type "FINAL")
    (Description "After target selection.")
  )

  (Event "merge"
    (Name "merge")
    (Priority_Number "0")
    (Operation "set merged=1, set link to merge run")
    (Parameters "merge run")
  )

  (Event "select"
    (Name "select")
    (Priority_Number "0")
    (Description "Select those object lists which will be considered primary object lists, and assign secondary status to others.")
  )

  (Event "target"
    (Name "target")
    (Priority_Number "0")
    (Description "Select spectroscopic targets.")
  )

  (Interaction "matches"
    (Name "matches")
    (Update "TRUE")
  )

  (Interaction "matches,status"
    (Name "matches,status")
    (Update "TRUE")
  )

  (Interaction "mergeRun"
    (Name "mergeRun")
    (Read "TRUE")
    (Update "TRUE")
  )

  (Interaction "object IDs"
    (Name "object IDs")
    (Read "TRUE")
  )

  (Interaction "others"
    (Name "others")
    (Update "TRUE")
  )

  (Interaction "status"
    (Name "status")
    (Read "TRUE")
    (Update "TRUE")
  )

  (Interaction "x,y"
    (Name "x,y")
    (Read "TRUE")
  )

  (Interaction "x,y,matches"
    (Name "x,y,matches")
    (Read "TRUE")
  )

  (Link "test"
    (Name "test")
  )

  (Link "y"
    (Name "y")
  )

  (Attribute "Action.name"
    (Name "name")
    (Type "STRING")
    (Description "The name of the action.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Action.name" "Action" "Action.name")

  (Attribute "Action.version"
    (Name "version")
    (Type "STRING")
    (Description "The version of the action.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Action.version" "Action" "Action.version")

  (Attribute "Action.description"
    (Name "description")
    (Type "STRING")
    (Description "A description.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Action.description" "Action" "Action.description")

  (Operation "Action.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Action.c0" "Action" "Action.c0")

  (Operation "Action.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Action.c1" "Action" "Action.c1")

  (Association "Action.Person "
    (Role2 "caretaker")
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Action.Person " "Action" "Person ")

  (Aggregation "Action.Parameter  "
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Action.Parameter  " "Action" "Parameter  ")

  (Aggregation "Action.Parameter Value"
    (Role2 "default")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Action.Parameter Value" "Action" "Parameter Value")

  (Attribute "Astrometric Calibration.incl"
    (Name "incl")
    (Document "degrees")
    (Type "float64")
    (Initial_Value "XXX.XXXXX")
    (Description "Great circle inclination wrt cel. eq.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Calibration.incl" "Astrometric Calibration" "Astrometric Calibration.incl")

  (Attribute "Astrometric Calibration.node"
    (Name "node")
    (Document "degrees")
    (Type "float64")
    (Initial_Value "XXX.XXXXX")
    (Description "RA of great circle's asending node.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Calibration.node" "Astrometric Calibration" "Astrometric Calibration.node")

  (Attribute "Astrometric Calibration.equinox"
    (Name "equinox")
    (Document "years")
    (Type "float64")
    (Initial_Value "XXXX.XX")
    (Description "Equinox of great circle coordinates.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Calibration.equinox" "Astrometric Calibration" "Astrometric Calibration.equinox")

  (Attribute "Astrometric Calibration.field0"
    (Name "field0")
    (Type "uint16")
    (Description "First field reduced.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Calibration.field0" "Astrometric Calibration" "Astrometric Calibration.field0")

  (Operation "Astrometric Calibration.trans"
    (Name "trans")
    (Description "Return the astrometric transformation for the specified field.")
    (Return_Type "const arFieldTrans&")
    (Formal_Parameters "uint8 camCol, uint16 field")
    (Constant "TRUE")
  )
  (Class.Operation "Astrometric Calibration.trans" "Astrometric Calibration" "Astrometric Calibration.trans")

  (Operation "Astrometric Calibration.nFields"
    (Name "nFields")
    (Description "Return the number of fields reduced.")
    (Return_Type "uint16")
    (Constant "TRUE")
  )
  (Class.Operation "Astrometric Calibration.nFields" "Astrometric Calibration" "Astrometric Calibration.nFields")

  (Operation "Astrometric Calibration.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Astrometric Calibration.c0" "Astrometric Calibration" "Astrometric Calibration.c0")

  (Operation "Astrometric Calibration.c2"
    (Name "c2")
    (Operation "const VARRAY<arFieldTrans>& col4, ")
    (Document "const VARRAY<arFieldTrans>& col3, ")
    (Source "const VARRAY<arFieldTrans>& col2, ")
    (Description "Constructor.  Each array is ordered by field, starting with field0.")
    (Category "CONSTRUCTOR")
    (Reads "const VARRAY<arFieldTrans>& col5, ")
    (Changes "const VARRAY<arFieldTrans>& col6")
    (Formal_Parameters "float64 incl, float64 node, float64 equinox, uint16 field0, const VARRAY<arFieldTrans>& col1, ")
  )
  (Class.Operation "Astrometric Calibration.c2" "Astrometric Calibration" "Astrometric Calibration.c2")

  (Aggregation "Astrometric Calibration.Astrometric Transformation"
    (Multiplicity2 "MANY")
    (Container1 "UP UNI ooVArray(arFieldTrans)[6]")
    (Static "TRUE")
  )
  (Class.Aggregation.Class "Astrometric Calibration.Astrometric Transformation" "Astrometric Calibration" "Astrometric Transformation")

  (Generalization "Astrometric Calibration.Product"
  )
  (Class.Generalization.Class "Astrometric Calibration.Product" "Astrometric Calibration" "Product")

  (Generalization "Astrometric Pipeline Plan.Plan Entry"
  )
  (Class.Generalization.Class "Astrometric Pipeline Plan.Plan Entry" "Astrometric Pipeline Plan" "Plan Entry")

  (Attribute "Astrometric Transformation.a"
    (Name "a")
    (Type "float64")
    (Description "A.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Transformation.a" "Astrometric Transformation" "Astrometric Transformation.a")

  (Attribute "Astrometric Transformation.b"
    (Name "b")
    (Type "float64")
    (Description "B.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Transformation.b" "Astrometric Transformation" "Astrometric Transformation.b")

  (Attribute "Astrometric Transformation.c"
    (Name "c")
    (Type "float64")
    (Description "C.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Transformation.c" "Astrometric Transformation" "Astrometric Transformation.c")

  (Attribute "Astrometric Transformation.d"
    (Name "d")
    (Type "float64")
    (Description "D.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Transformation.d" "Astrometric Transformation" "Astrometric Transformation.d")

  (Attribute "Astrometric Transformation.e"
    (Name "e")
    (Type "float64")
    (Description "E.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Transformation.e" "Astrometric Transformation" "Astrometric Transformation.e")

  (Attribute "Astrometric Transformation.f"
    (Name "f")
    (Type "float64")
    (Description "F.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Astrometric Transformation.f" "Astrometric Transformation" "Astrometric Transformation.f")

  (Operation "Astrometric Transformation.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Astrometric Transformation.c0" "Astrometric Transformation" "Astrometric Transformation.c0")

  (Operation "Astrometric Transformation.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Astrometric Transformation.c1" "Astrometric Transformation" "Astrometric Transformation.c1")

  (Association "Astrometric Transformation.Frame"
    (Multiplicity1 "MANY")
    (Container1 "PRIMARY")
  )
  (Class.Association.Class "Astrometric Transformation.Frame" "Astrometric Transformation" "Frame")

  (Attribute "Atlas Image.nCols"
    (Name "nCols")
    (Type "uint16")
    (Description "Number of columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Atlas Image.nCols" "Atlas Image" "Atlas Image.nCols")

  (Attribute "Atlas Image.nRows"
    (Name "nRows")
    (Type "uint16")
    (Description "Number of rows.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Atlas Image.nRows" "Atlas Image" "Atlas Image.nRows")

  (Attribute "Atlas Image.col0"
    (Name "col0")
    (Type "uint16")
    (Description "Frame column of lower left-hand pixel.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Atlas Image.col0" "Atlas Image" "Atlas Image.col0")

  (Attribute "Atlas Image.row0"
    (Name "row0")
    (Type "uint16")
    (Description "Frame row of lower left-hand pixel.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Atlas Image.row0" "Atlas Image" "Atlas Image.row0")

  (Attribute "Atlas Image.pixelMap"
    (Name "pixelMap")
    (Document "counts")
    (Type "uint16")
    (Size "V")
    (Description "Actual pixel values from the corrected frame.  Stored with column as the fastest varying index.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Atlas Image.pixelMap" "Atlas Image" "Atlas Image.pixelMap")

  (Attribute "Atlas Image.objectMask"
    (Name "objectMask")
    (Type "char")
    (Size "V")
    (Description "Bit-mask of the object pixels.  Stored with columns as the fastest-varying index.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Atlas Image.objectMask" "Atlas Image" "Atlas Image.objectMask")

  (Association "Bias Vector.Frame"
    (Multiplicity1 "MANY")
    (Container1 "PRIMARY")
  )
  (Class.Association.Class "Bias Vector.Frame" "Bias Vector" "Frame")

  (Attribute "Binned Noise Frame.pixelMap"
    (Name "pixelMap")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
  )
  (Class.Attribute "Binned Noise Frame.pixelMap" "Binned Noise Frame" "Binned Noise Frame.pixelMap")

  (Attribute "Calibrated Magnitude.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibrated Magnitude.filter" "Calibrated Magnitude" "Calibrated Magnitude.filter")

  (Attribute "Calibrated Magnitude.mag"
    (Name "mag")
    (Type "arMag")
    (Size "5")
    (Description "Magnitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibrated Magnitude.mag" "Calibrated Magnitude" "Calibrated Magnitude.mag")

  (Association "Calibrated Patch.Excalibur Run"
    (Multiplicity1 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Calibrated Patch.Excalibur Run" "Calibrated Patch" "Excalibur Run")

  (Association "Calibrated Patch.MT Star List"
  )
  (Class.Association.Class "Calibrated Patch.MT Star List" "Calibrated Patch" "MT Star List")

  (Aggregation "Calibrated Patch.Calibrated Secondary Star"
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Calibrated Patch.Calibrated Secondary Star" "Calibrated Patch" "Calibrated Secondary Star")

  (Attribute "Calibrated Secondary Star.coord"
    (Name "coord")
    (Type "arSurveyCoord")
    (Description "Survey coordinates.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibrated Secondary Star.coord" "Calibrated Secondary Star" "Calibrated Secondary Star.coord")

  (Aggregation "Calibrated Secondary Star.Calibrated Magnitude"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Calibrated Secondary Star.Calibrated Magnitude" "Calibrated Secondary Star" "Calibrated Magnitude")

  (Attribute "Calibration Coefficient.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibration Coefficient.filter" "Calibration Coefficient" "Calibration Coefficient.filter")

  (Attribute "Calibration Coefficient.value"
    (Name "value")
    (Type "arFloatErr")
    (Description "Coefficient value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibration Coefficient.value" "Calibration Coefficient" "Calibration Coefficient.value")

  (Attribute "Calibration Patch.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera covered by this patch.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibration Patch.camCol" "Calibration Patch" "Calibration Patch.camCol")

  (Attribute "Calibration Patch.coord"
    (Name "coord")
    (Type "arSurveyCoord")
    (Description "Survey coordinates of the patch center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Calibration Patch.coord" "Calibration Patch" "Calibration Patch.coord")

  (Operation "Calibration Patch.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Calibration Patch.c0" "Calibration Patch" "Calibration Patch.c0")

  (Operation "Calibration Patch.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Calibration Patch.c1" "Calibration Patch" "Calibration Patch.c1")

  (Operation "Calibration Patch.~"
    (Name "~")
    (Description "Destructor.")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "Calibration Patch.~" "Calibration Patch" "Calibration Patch.~")

  (Generalization "Calibration Patch.MT Target"
  )
  (Class.Generalization.Class "Calibration Patch.MT Target" "Calibration Patch" "MT Target")

  (Attribute "Corrected Frame.pixelMap"
    (Name "pixelMap")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
  )
  (Class.Attribute "Corrected Frame.pixelMap" "Corrected Frame" "Corrected Frame.pixelMap")

  (Attribute "Corrected Frame.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter (u, g, r, i, or z).")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Corrected Frame.filter" "Corrected Frame" "Corrected Frame.filter")

  (Aggregation "Corrected Frame.Binned Noise Frame"
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Corrected Frame.Binned Noise Frame" "Corrected Frame" "Binned Noise Frame")

  (Aggregation "Corrected Frame.Frame Statistic"
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Corrected Frame.Frame Statistic" "Corrected Frame" "Frame Statistic")

  (Attribute "DA Star.rowCentroid"
    (Name "rowCentroid")
    (Type "float32")
    (Description "Row position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rowCentroid" "DA Star" "DA Star.rowCentroid")

  (Attribute "DA Star.colCentroid"
    (Name "colCentroid")
    (Type "float32")
    (Description "Column position of star center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.colCentroid" "DA Star" "DA Star.colCentroid")

  (Attribute "DA Star.stampThresh"
    (Name "stampThresh")
    (Document "ADUs")
    (Type "float32")
    (Description "(Boundary) stamp threshold.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.stampThresh" "DA Star" "DA Star.stampThresh")

  (Attribute "DA Star.sumWeights"
    (Name "sumWeights")
    (Type "float32")
    (Description "Sum of the weights.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.sumWeights" "DA Star" "DA Star.sumWeights")

  (Attribute "DA Star.quadMomRR"
    (Name "quadMomRR")
    (Document "pixels")
    (Type "float32")
    (Description "Row-row (xx) 2nd moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.quadMomRR" "DA Star" "DA Star.quadMomRR")

  (Attribute "DA Star.quadMomRC"
    (Name "quadMomRC")
    (Document "pixels")
    (Type "float32")
    (Description "Row-column (xy) 2nd moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.quadMomRC" "DA Star" "DA Star.quadMomRC")

  (Attribute "DA Star.quadMomCC"
    (Name "quadMomCC")
    (Document "pixels")
    (Type "float32")
    (Description "Column-column (yy) 2nd moment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.quadMomCC" "DA Star" "DA Star.quadMomCC")

  (Attribute "DA Star.eccentricity"
    (Name "eccentricity")
    (Type "float32")
    (Description "Eccentricity.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.eccentricity" "DA Star" "DA Star.eccentricity")

  (Attribute "DA Star.rMajor"
    (Name "rMajor")
    (Document "pixels")
    (Type "float32")
    (Description "Major axis radius. ")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rMajor" "DA Star" "DA Star.rMajor")

  (Attribute "DA Star.rMinor"
    (Name "rMinor")
    (Document "pixels")
    (Type "float32")
    (Description "Minor axis radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rMinor" "DA Star" "DA Star.rMinor")

  (Attribute "DA Star.angMajorAxis"
    (Name "angMajorAxis")
    (Document "degrees")
    (Type "float32")
    (Description "Major axis position angle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.angMajorAxis" "DA Star" "DA Star.angMajorAxis")

  (Attribute "DA Star.angMinorAxis"
    (Name "angMinorAxis")
    (Document "degrees")
    (Type "float32")
    (Description "Minor axis position angle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.angMinorAxis" "DA Star" "DA Star.angMinorAxis")

  (Attribute "DA Star.rowAmp"
    (Name "rowAmp")
    (Document "ADUs")
    (Type "float32")
    (Description "Amplitude of fit along the row marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rowAmp" "DA Star" "DA Star.rowAmp")

  (Attribute "DA Star.rowSky"
    (Name "rowSky")
    (Document "ADUs/pixel")
    (Type "float32")
    (Description "Sky value along the row marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rowSky" "DA Star" "DA Star.rowSky")

  (Attribute "DA Star.rowCenter"
    (Name "rowCenter")
    (Type "float32")
    (Description "Mean for the row marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rowCenter" "DA Star" "DA Star.rowCenter")

  (Attribute "DA Star.rowSigma"
    (Name "rowSigma")
    (Document "pixels")
    (Type "float32")
    (Description "Sigma for the row marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rowSigma" "DA Star" "DA Star.rowSigma")

  (Attribute "DA Star.numRowPixels"
    (Name "numRowPixels")
    (Type "uint32")
    (Description "Number of pixels for row fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.numRowPixels" "DA Star" "DA Star.numRowPixels")

  (Attribute "DA Star.rowReducedChi2"
    (Name "rowReducedChi2")
    (Type "float32")
    (Description "Reduced chi-quare of the row fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.rowReducedChi2" "DA Star" "DA Star.rowReducedChi2")

  (Attribute "DA Star.colAmp"
    (Name "colAmp")
    (Document "ADUs")
    (Type "float32")
    (Description "Amplitude of fit along the col marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.colAmp" "DA Star" "DA Star.colAmp")

  (Attribute "DA Star.colSky"
    (Name "colSky")
    (Document "ADUs/pixel")
    (Type "float32")
    (Description "Sky value along the col marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.colSky" "DA Star" "DA Star.colSky")

  (Attribute "DA Star.colCenter"
    (Name "colCenter")
    (Type "float32")
    (Description "Mean for the col marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.colCenter" "DA Star" "DA Star.colCenter")

  (Attribute "DA Star.colSigma"
    (Name "colSigma")
    (Document "pixels")
    (Type "float32")
    (Description "Sigma for the col marginal.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "30")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.colSigma" "DA Star" "DA Star.colSigma")

  (Attribute "DA Star.numColPixels"
    (Name "numColPixels")
    (Type "uint32")
    (Description "Number of pixels used for col fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.numColPixels" "DA Star" "DA Star.numColPixels")

  (Attribute "DA Star.colReducedChi2"
    (Name "colReducedChi2")
    (Type "float32")
    (Description "Reduced chi-square of the col fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.colReducedChi2" "DA Star" "DA Star.colReducedChi2")

  (Attribute "DA Star.statusFit"
    (Name "statusFit")
    (Type "uint32")
    (Description "0=ok, less than 0 implies error.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "DA Star.statusFit" "DA Star" "DA Star.statusFit")

  (Operation "DA Star.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "DA Star.c0" "DA Star" "DA Star.c0")

  (Operation "DA Star.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "DA Star.c1" "DA Star" "DA Star.c1")

  (Attribute "Detection.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter for this detection (u, g, r, i, or z).")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Detection.filter" "Detection" "Detection.filter")

  (Attribute "Detection.x"
    (Name "x")
    (Document "pixels")
    (Type "arFloatErr")
    (Description "Object center along rows.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Detection.x" "Detection" "Detection.x")

  (Attribute "Detection.y"
    (Name "y")
    (Document "pixels")
    (Type "arFloatErr")
    (Description "Object center along columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Detection.y" "Detection" "Detection.y")

  (Attribute "Detection.flags"
    (Name "flags")
    (Type "uint8")
    (Description "Flags.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Detection.flags" "Detection" "Detection.flags")

  (Aggregation "Detection.Atlas Image"
    (Container1 "UP")
  )
  (Class.Aggregation.Class "Detection.Atlas Image" "Detection" "Atlas Image")

  (Attribute "Double Precision Measurement.value"
    (Name "value")
    (Type "o_double")
    (Description "The measured value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Double Precision Measurement.value" "Double Precision Measurement" "Double Precision Measurement.value")

  (Attribute "Double Precision Measurement.variance"
    (Name "variance")
    (Type "o_float")
    (Description "The variance in the measured value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Double Precision Measurement.variance" "Double Precision Measurement" "Double Precision Measurement.variance")

  (Operation "Double Precision Measurement.sin"
    (Name "sin")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.sin" "Double Precision Measurement" "Double Precision Measurement.sin")

  (Operation "Double Precision Measurement.exp"
    (Name "exp")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.exp" "Double Precision Measurement" "Double Precision Measurement.exp")

  (Operation "Double Precision Measurement.err"
    (Name "err")
    (Return_Type "o_float")
  )
  (Class.Operation "Double Precision Measurement.err" "Double Precision Measurement" "Double Precision Measurement.err")

  (Operation "Double Precision Measurement.cos"
    (Name "cos")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.cos" "Double Precision Measurement" "Double Precision Measurement.cos")

  (Operation "Double Precision Measurement.arDoubleErr(o_double value, o_float err=0)"
    (Name "arDoubleErr(o_double value, o_float err=0)")
    (Operation "arDoubleErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double value, o_float err=0")
  )
  (Class.Operation "Double Precision Measurement.arDoubleErr(o_double value, o_float err=0)" "Double Precision Measurement" "Double Precision Measurement.arDoubleErr(o_double value, o_float err=0)")

  (Operation "Double Precision Measurement.arDoubleErr(const arDoubleErr& other)"
    (Name "arDoubleErr(const arDoubleErr& other)")
    (Operation "arDoubleErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arDoubleErr& other")
  )
  (Class.Operation "Double Precision Measurement.arDoubleErr(const arDoubleErr& other)" "Double Precision Measurement" "Double Precision Measurement.arDoubleErr(const arDoubleErr& other)")

  (Operation "Double Precision Measurement.arDoubleErr"
    (Name "arDoubleErr")
    (Operation "arDoubleErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arFloatErr& value")
  )
  (Class.Operation "Double Precision Measurement.arDoubleErr" "Double Precision Measurement" "Double Precision Measurement.arDoubleErr")

  (Operation "Double Precision Measurement.set"
    (Name "set")
    (Category "MODIFIER")
    (Formal_Parameters "o_double value, o_float err")
  )
  (Class.Operation "Double Precision Measurement.set" "Double Precision Measurement" "Double Precision Measurement.set")

  (Operation "Double Precision Measurement.sqrt"
    (Name "sqrt")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.sqrt" "Double Precision Measurement" "Double Precision Measurement.sqrt")

  (Operation "Double Precision Measurement.log"
    (Name "log")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.log" "Double Precision Measurement" "Double Precision Measurement.log")

  (Operation "Double Precision Measurement.*"
    (Name "*")
    (Operation "operator*")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v1, arDoubleErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.*" "Double Precision Measurement" "Double Precision Measurement.*")

  (Operation "Double Precision Measurement.+"
    (Name "+")
    (Operation "operator+")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v1, arDoubleErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.+" "Double Precision Measurement" "Double Precision Measurement.+")

  (Operation "Double Precision Measurement.tan"
    (Name "tan")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.tan" "Double Precision Measurement" "Double Precision Measurement.tan")

  (Operation "Double Precision Measurement.-"
    (Name "-")
    (Operation "operator-")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v1, arDoubleErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.-" "Double Precision Measurement" "Double Precision Measurement.-")

  (Operation "Double Precision Measurement./"
    (Name "/")
    (Operation "operator/")
    (Return_Type "arDoubleErr")
    (Formal_Parameters "arDoubleErr v1, arDoubleErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement./" "Double Precision Measurement" "Double Precision Measurement./")

  (Operation "Double Precision Measurement.<<"
    (Name "<<")
    (Operation "operator<<")
    (Return_Type "ostream&")
    (Formal_Parameters "ostream& s, const arDoubleErr& value")
    (Friend "TRUE")
  )
  (Class.Operation "Double Precision Measurement.<<" "Double Precision Measurement" "Double Precision Measurement.<<")

  (Operation "Double Precision Measurement.+="
    (Name "+=")
    (Operation "operator+=")
    (Category "MODIFIER")
    (Return_Type "arDoubleErr&")
    (Formal_Parameters "arDoubleErr other")
  )
  (Class.Operation "Double Precision Measurement.+=" "Double Precision Measurement" "Double Precision Measurement.+=")

  (Operation "Double Precision Measurement.-="
    (Name "-=")
    (Operation "operator-=")
    (Category "MODIFIER")
    (Return_Type "arDoubleErr&")
    (Formal_Parameters "arDoubleErr other")
  )
  (Class.Operation "Double Precision Measurement.-=" "Double Precision Measurement" "Double Precision Measurement.-=")

  (Operation "Double Precision Measurement.*="
    (Name "*=")
    (Operation "operator*=")
    (Category "MODIFIER")
    (Return_Type "arDoubleErr&")
    (Formal_Parameters "arDoubleErr other")
  )
  (Class.Operation "Double Precision Measurement.*=" "Double Precision Measurement" "Double Precision Measurement.*=")

  (Operation "Double Precision Measurement./="
    (Name "/=")
    (Operation "operator/=")
    (Category "MODIFIER")
    (Return_Type "arDoubleErr&")
    (Formal_Parameters "arDoubleErr other")
  )
  (Class.Operation "Double Precision Measurement./=" "Double Precision Measurement" "Double Precision Measurement./=")

  (Attribute "Equatorial Coordinate.equinox"
    (Name "equinox")
    (Type "o_double")
    (Description "Equinox, in decimal years, of the coordinates.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Equatorial Coordinate.equinox" "Equatorial Coordinate" "Equatorial Coordinate.equinox")

  (Operation "Equatorial Coordinate.arEquatorialCoordd"
    (Name "arEquatorialCoordd")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double longitude, o_double latitude, o_double equinox")
  )
  (Class.Operation "Equatorial Coordinate.arEquatorialCoordd" "Equatorial Coordinate" "Equatorial Coordinate.arEquatorialCoordd")

  (Operation "Equatorial Coordinate.arEquatorialCoord(const arEquatorialCoord& other)"
    (Name "arEquatorialCoord(const arEquatorialCoord& other)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arEquatorialCoord& other")
  )
  (Class.Operation "Equatorial Coordinate.arEquatorialCoord(const arEquatorialCoord& other)" "Equatorial Coordinate" "Equatorial Coordinate.arEquatorialCoord(const arEquatorialCoord& other)")

  (Operation "Equatorial Coordinate.distance"
    (Name "distance")
    (Formal_Parameters "const arEquatorialCoord& other")
    (Constant "TRUE")
  )
  (Class.Operation "Equatorial Coordinate.distance" "Equatorial Coordinate" "Equatorial Coordinate.distance")

  (Operation "Equatorial Coordinate.positionAngle"
    (Name "positionAngle")
    (Formal_Parameters "const arEquatorialCoord& other")
    (Constant "TRUE")
  )
  (Class.Operation "Equatorial Coordinate.positionAngle" "Equatorial Coordinate" "Equatorial Coordinate.positionAngle")

  (Operation "Equatorial Coordinate.precess"
    (Name "precess")
    (Category "MODIFIER")
    (Formal_Parameters "o_double equinox")
  )
  (Class.Operation "Equatorial Coordinate.precess" "Equatorial Coordinate" "Equatorial Coordinate.precess")

  (Operation "Equatorial Coordinate.<<"
    (Name "<<")
    (Formal_Parameters "ostream& s, const arEquatorialCoord& coord")
    (Friend "TRUE")
  )
  (Class.Operation "Equatorial Coordinate.<<" "Equatorial Coordinate" "Equatorial Coordinate.<<")

  (Generalization "Equatorial Coordinate.Spherical Coordinate"
  )
  (Class.Generalization.Class "Equatorial Coordinate.Spherical Coordinate" "Equatorial Coordinate" "Spherical Coordinate")

  (Association "Excalibur Plan.MT Star List"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Excalibur Plan.MT Star List" "Excalibur Plan" "MT Star List")

  (Association "Excalibur Plan.Primary Standards Set"
    (Multiplicity1 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Excalibur Plan.Primary Standards Set" "Excalibur Plan" "Primary Standards Set")

  (Attribute "Excalibur Run.chiSq"
    (Name "chiSq")
    (Type "float32")
    (Description "Chi-square of the fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Excalibur Run.chiSq" "Excalibur Run" "Excalibur Run.chiSq")

  (Operation "Excalibur Run.startTime"
    (Name "startTime")
    (Return_Type "VTime&")
    (Constant "TRUE")
    (Inline "TRUE")
  )
  (Class.Operation "Excalibur Run.startTime" "Excalibur Run" "Excalibur Run.startTime")

  (Operation "Excalibur Run.endTime"
    (Name "endTime")
    (Description "Return the end of the time bracket over which this is valid.")
    (Return_Type "sdbTime")
  )
  (Class.Operation "Excalibur Run.endTime" "Excalibur Run" "Excalibur Run.endTime")

  (Operation "Excalibur Run.coefficient"
    (Name "coefficient")
    (Description "Return the value of the specified coefficient at the given time, using the specified interpolation schema.")
    (Return_Type "o_float")
    (Formal_Parameters "arMTCoefficient coefficient, const sdbTime& time, arMTInterpolation interp")
    (Constant "TRUE")
  )
  (Class.Operation "Excalibur Run.coefficient" "Excalibur Run" "Excalibur Run.coefficient")

  (Association "Excalibur Run.old color terms.Photometric Calibration"
    (Name "old color terms")
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
  )
  (Class.Association.Class "Excalibur Run.old color terms.Photometric Calibration" "Excalibur Run" "Photometric Calibration")

  (Association "Excalibur Run.MT Star List"
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Excalibur Run.MT Star List" "Excalibur Run" "MT Star List")

  (Association "Excalibur Run.Primary Standards Set"
    (Multiplicity1 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Excalibur Run.Primary Standards Set" "Excalibur Run" "Primary Standards Set")

  (Association "Excalibur Run.Excalibur Run"
    (Role2 "color terms")
    (Multiplicity1 "MANY")
    (Multiplicity2 "OPTIONAL")
    (Friend "TRUE")
  )
  (Class.Association.Class "Excalibur Run.Excalibur Run" "Excalibur Run" "Excalibur Run")

  (Aggregation "Excalibur Run.zero points.Photometric Calibration"
    (Name "zero points")
    (Multiplicity2 "ONE OR MORE")
  )
  (Class.Aggregation.Class "Excalibur Run.zero points.Photometric Calibration" "Excalibur Run" "Photometric Calibration")

  (Aggregation "Excalibur Run.extinction.Photometric Calibration"
    (Name "extinction")
    (Multiplicity2 "ONE OR MORE")
  )
  (Class.Aggregation.Class "Excalibur Run.extinction.Photometric Calibration" "Excalibur Run" "Photometric Calibration")

  (Aggregation "Excalibur Run.color terms.Photometric Calibration"
    (Name "color terms")
    (Multiplicity2 "MANY")
  )
  (Class.Aggregation.Class "Excalibur Run.color terms.Photometric Calibration" "Excalibur Run" "Photometric Calibration")

  (Aggregation "Excalibur Run.MT Calibration"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Excalibur Run.MT Calibration" "Excalibur Run" "MT Calibration")

  (Generalization "Excalibur Run.Product"
  )
  (Class.Generalization.Class "Excalibur Run.Product" "Excalibur Run" "Product")

  (Attribute "Exposure.expTime"
    (Name "expTime")
    (Document "seconds")
    (Type "float32")
    (Description "Exposure time.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.expTime" "Exposure" "Exposure.expTime")

  (Attribute "Exposure.tai"
    (Name "tai")
    (Type "arTime")
    (Description "TAI at the start of the exposure.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.tai" "Exposure" "Exposure.tai")

  (Attribute "Exposure.prescan"
    (Name "prescan")
    (Type "uint16")
    (Description "Number of prescan columns read per amplifier.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.prescan" "Exposure" "Exposure.prescan")

  (Attribute "Exposure.overscan"
    (Name "overscan")
    (Type "uint16")
    (Description "Number of overscan columns read per amplifier.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.overscan" "Exposure" "Exposure.overscan")

  (Attribute "Exposure.sidescan"
    (Name "sidescan")
    (Type "uint16")
    (Description "Number of sidescan rows read per amplifier.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.sidescan" "Exposure" "Exposure.sidescan")

  (Attribute "Exposure.nCols"
    (Name "nCols")
    (Type "uint16")
    (Description "Number of binned columns read.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.nCols" "Exposure" "Exposure.nCols")

  (Attribute "Exposure.nRows"
    (Name "nRows")
    (Type "uint16")
    (Description "Number of binned rows read.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.nRows" "Exposure" "Exposure.nRows")

  (Attribute "Exposure.col1"
    (Name "col1")
    (Type "uint16")
    (Description "First binned column read (0-indexed).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.col1" "Exposure" "Exposure.col1")

  (Attribute "Exposure.row1"
    (Name "row1")
    (Type "uint16")
    (Description "First binned row read (0-indexed).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.row1" "Exposure" "Exposure.row1")

  (Attribute "Exposure.coord"
    (Name "coord")
    (Type "arEquatorialCoord")
    (Description "Equatorial coordinates of the telescope pointing.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.coord" "Exposure" "Exposure.coord")

  (Attribute "Exposure.colBin"
    (Name "colBin")
    (Type "uint16")
    (Description "Binning factor perpendicular to the columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.colBin" "Exposure" "Exposure.colBin")

  (Attribute "Exposure.rowBin"
    (Name "rowBin")
    (Type "uint16")
    (Description "Binning factor perpendicular to the rows.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Exposure.rowBin" "Exposure" "Exposure.rowBin")

  (Operation "Exposure.zenithDistance"
    (Name "zenithDistance")
    (Description "Return the zenith distance at the start of this exposure.  Default values for observatory longitude and latitude are for APO.")
    (Return_Type "float32")
    (Formal_Parameters "float32 longitude=105.82000, float32 latitude=32.78056")
    (Constant "TRUE")
  )
  (Class.Operation "Exposure.zenithDistance" "Exposure" "Exposure.zenithDistance")

  (Operation "Exposure.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Exposure.c0" "Exposure" "Exposure.c0")

  (Operation "Exposure.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Exposure.c1" "Exposure" "Exposure.c1")

  (Operation "Exposure.airmass"
    (Name "airmass")
    (Description "Return the airmass at the start of the exposure.  Default values for the observatory longitude and latitude are for APO.")
    (Return_Type "float32")
    (Formal_Parameters "flaot32 longitude = 105.82000, float32 latitude = 32.78056")
    (Constant "TRUE")
  )
  (Class.Operation "Exposure.airmass" "Exposure" "Exposure.airmass")

  (Attribute "Field.id"
    (Name "id")
    (Type "uint16")
    (Description "Field sequence number within the run.  0 indexed.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Field.id" "Field" "Field.id")

  (Attribute "Field.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Field.camCol" "Field" "Field.camCol")

  (Aggregation "Field.Frame"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Field.Frame" "Field" "Frame")

  (Association "Flat Field Vector.Frame"
    (Multiplicity1 "MANY")
    (Container1 "PRIMARY")
  )
  (Class.Association.Class "Flat Field Vector.Frame" "Flat Field Vector" "Frame")

  (Attribute "Frame.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter (u, g, r, i, z, l, or t).")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame.filter" "Frame" "Frame.filter")

  (Attribute "Frame.pixelMap"
    (Name "pixelMap")
    (Scope "IMPLEMENTATION")
    (Key_Number "0")
  )
  (Class.Attribute "Frame.pixelMap" "Frame" "Frame.pixelMap")

  (Operation "Frame.camRow"
    (Name "camRow")
    (Description "Row in the imaging camera of the CCD which took this frame.")
    (Return_Type "uint8")
    (Inline "TRUE")
  )
  (Class.Operation "Frame.camRow" "Frame" "Frame.camRow")

  (Aggregation "Frame.Postage Stamp"
    (Multiplicity2 "MANY")
    (Container1 "UP")
  )
  (Class.Aggregation.Class "Frame.Postage Stamp" "Frame" "Postage Stamp")

  (Aggregation "Frame.Quartile"
    (Multiplicity2 "MANY")
    (Container1 "UP")
  )
  (Class.Aggregation.Class "Frame.Quartile" "Frame" "Quartile")

  (Attribute "Frame Parameters.fwhm"
    (Name "fwhm")
    (Document "pixels")
    (Type "float32")
    (Description "Median FWHM of brightest objects on the frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Parameters.fwhm" "Frame Parameters" "Frame Parameters.fwhm")

  (Attribute "Frame Parameters.sky"
    (Name "sky")
    (Document "counts/pixel")
    (Type "arFloatErr")
    (Description "Global sky value for the frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Parameters.sky" "Frame Parameters" "Frame Parameters.sky")

  (Association "Frame Parameters.MT Exposure"
    (Multiplicity1 "MANY")
    (Container1 "PRIMARY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Frame Parameters.MT Exposure" "Frame Parameters" "MT Exposure")

  (Attribute "Frame Statistic.minPix"
    (Name "minPix")
    (Document "counts")
    (Type "float32")
    (Description "Minimum pixel value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.minPix" "Frame Statistic" "Frame Statistic.minPix")

  (Attribute "Frame Statistic.maxPix"
    (Name "maxPix")
    (Document "counts")
    (Type "float32")
    (Description "Maximum pixel value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.maxPix" "Frame Statistic" "Frame Statistic.maxPix")

  (Attribute "Frame Statistic.meanPix"
    (Name "meanPix")
    (Document "counts")
    (Type "float32")
    (Description "Mean pixel value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.meanPix" "Frame Statistic" "Frame Statistic.meanPix")

  (Attribute "Frame Statistic.sigPix"
    (Name "sigPix")
    (Document "counts")
    (Type "float32")
    (Description "Sigma of pixel values in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.sigPix" "Frame Statistic" "Frame Statistic.sigPix")

  (Attribute "Frame Statistic.sky"
    (Name "sky")
    (Document "counts/pixel")
    (Type "float32")
    (Description "Mean sky value in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.sky" "Frame Statistic" "Frame Statistic.sky")

  (Attribute "Frame Statistic.nBadPix"
    (Name "nBadPix")
    (Type "uint32")
    (Description "Number of bad pixels in the corrected frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.nBadPix" "Frame Statistic" "Frame Statistic.nBadPix")

  (Attribute "Frame Statistic.nBrightObj"
    (Name "nBrightObj")
    (Type "uint16")
    (Description "Number of bright objects detected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.nBrightObj" "Frame Statistic" "Frame Statistic.nBrightObj")

  (Attribute "Frame Statistic.nFaintObj"
    (Name "nFaintObj")
    (Type "uint16")
    (Description "Number of faint objects detected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frame Statistic.nFaintObj" "Frame Statistic" "Frame Statistic.nFaintObj")

  (Attribute "Frames Pipeline Plan.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "SECONDARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frames Pipeline Plan.camCol" "Frames Pipeline Plan" "Frames Pipeline Plan.camCol")

  (Generalization "Frames Pipeline Plan.Plan Entry"
  )
  (Class.Generalization.Class "Frames Pipeline Plan.Plan Entry" "Frames Pipeline Plan" "Plan Entry")

  (Attribute "Frames Pipeline Run.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "SECONDARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frames Pipeline Run.camCol" "Frames Pipeline Run" "Frames Pipeline Run.camCol")

  (Attribute "Frames Pipeline Run.field0"
    (Name "field0")
    (Type "uint16")
    (Description "First field reduced.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Frames Pipeline Run.field0" "Frames Pipeline Run" "Frames Pipeline Run.field0")

  (Aggregation "Frames Pipeline Run.Object List"
    (Multiplicity2 "MANY")
  )
  (Class.Aggregation.Class "Frames Pipeline Run.Object List" "Frames Pipeline Run" "Object List")

  (Generalization "Frames Pipeline Run.Product"
  )
  (Class.Generalization.Class "Frames Pipeline Run.Product" "Frames Pipeline Run" "Product")

  (Association "Image Pipeline Plan.Imaging Run"
    (Multiplicity1 "MANY")
    (Container1 "SECONDARY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Image Pipeline Plan.Imaging Run" "Image Pipeline Plan" "Imaging Run")

  (Aggregation "Image Pipeline Plan.Astrometric Pipeline Plan"
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Plan.Astrometric Pipeline Plan" "Image Pipeline Plan" "Astrometric Pipeline Plan")

  (Aggregation "Image Pipeline Plan.Postage Stamp Pipeline Plan"
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "6")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Plan.Postage Stamp Pipeline Plan" "Image Pipeline Plan" "Postage Stamp Pipeline Plan")

  (Aggregation "Image Pipeline Plan.SSC Pipeline Plan"
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Plan.SSC Pipeline Plan" "Image Pipeline Plan" "SSC Pipeline Plan")

  (Aggregation "Image Pipeline Plan.Frames Pipeline Plan"
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "6")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Plan.Frames Pipeline Plan" "Image Pipeline Plan" "Frames Pipeline Plan")

  (Generalization "Image Pipeline Plan.Plan Entry"
  )
  (Class.Generalization.Class "Image Pipeline Plan.Plan Entry" "Image Pipeline Plan" "Plan Entry")

  (Association "Image Pipeline Run.Imaging Run"
    (Container1 "SECONDARY")
  )
  (Class.Association.Class "Image Pipeline Run.Imaging Run" "Image Pipeline Run" "Imaging Run")

  (Aggregation "Image Pipeline Run.Astrometric Calibration"
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Run.Astrometric Calibration" "Image Pipeline Run" "Astrometric Calibration")

  (Aggregation "Image Pipeline Run.Postage Stamp Calibration"
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "6")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Run.Postage Stamp Calibration" "Image Pipeline Run" "Postage Stamp Calibration")

  (Aggregation "Image Pipeline Run.Frames Pipeline Run"
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "6")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Run.Frames Pipeline Run" "Image Pipeline Run" "Frames Pipeline Run")

  (Aggregation "Image Pipeline Run.SSC Pipeline Run"
    (Constraint2 "6")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Image Pipeline Run.SSC Pipeline Run" "Image Pipeline Run" "SSC Pipeline Run")

  (Attribute "Imaging Run.strip"
    (Name "strip")
    (Type "arStrip")
    (Description "Strip in the stripe being tracked.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Imaging Run.strip" "Imaging Run" "Imaging Run.strip")

  (Attribute "Imaging Run.id"
    (Name "id")
    (Type "uint32")
    (Description "Imaging run number.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.id" "Imaging Run" "Imaging Run.id")

  (Attribute "Imaging Run.flavor"
    (Name "flavor")
    (Type "arRunFlavor")
    (Description "Flavor of this run (e.g., science, calibration, test, ignore).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Imaging Run.flavor" "Imaging Run" "Imaging Run.flavor")

  (Attribute "Imaging Run.sys_scn"
    (Name "sys_scn")
    (Type "arGCSystem")
    (Description "Coordinate system of the scan great circle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Imaging Run.sys_scn" "Imaging Run" "Imaging Run.sys_scn")

  (Attribute "Imaging Run.eqnx_scn"
    (Name "eqnx_scn")
    (Document "years")
    (Type "float64")
    (Initial_Value "XXXX.XX")
    (Description "Equinox of the scan great circle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.eqnx_scn" "Imaging Run" "Imaging Run.eqnx_scn")

  (Attribute "Imaging Run.node"
    (Name "node")
    (Document "deg")
    (Type "float64")
    (Initial_Value "XXX.XXXXX")
    (Description "Ra of the great circle's ascending node.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.node" "Imaging Run" "Imaging Run.node")

  (Attribute "Imaging Run.incl"
    (Name "incl")
    (Document "deg")
    (Type "float64")
    (Initial_Value "XXX.XXXXX")
    (Description "Great circle's inclination wrt cel eq.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.incl" "Imaging Run" "Imaging Run.incl")

  (Attribute "Imaging Run.xBore"
    (Name "xBore")
    (Document "mm")
    (Type "float32")
    (Description "Boresight x offset from the array center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.xBore" "Imaging Run" "Imaging Run.xBore")

  (Attribute "Imaging Run.yBore"
    (Name "yBore")
    (Document "mm")
    (Type "float32")
    (Description "Boresight y offset from the array center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.yBore" "Imaging Run" "Imaging Run.yBore")

  (Attribute "Imaging Run.system"
    (Name "system")
    (Type "arGCSystem")
    (Description "System of the TCC coordinates.  These are the coordinates attached to each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Imaging Run.system" "Imaging Run" "Imaging Run.system")

  (Attribute "Imaging Run.equinox"
    (Name "equinox")
    (Document "years")
    (Type "float64")
    (Initial_Value "XXXX.XX")
    (Description "Equinox of the TCC coordinates.   These are the coordinates stored in each associated frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.equinox" "Imaging Run" "Imaging Run.equinox")

  (Attribute "Imaging Run.c_obs"
    (Name "c_obs")
    (Document "usec/row")
    (Type "float32")
    (Description "CCD row clock rate.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.c_obs" "Imaging Run" "Imaging Run.c_obs")

  (Attribute "Imaging Run.colBin"
    (Name "colBin")
    (Type "uint16")
    (Description "Binning factor perpendicular to the columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.colBin" "Imaging Run" "Imaging Run.colBin")

  (Attribute "Imaging Run.rowBin"
    (Name "rowBin")
    (Type "uint16")
    (Description "Binning factor perpendicular to the rows.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.rowBin" "Imaging Run" "Imaging Run.rowBin")

  (Attribute "Imaging Run.bias"
    (Name "bias")
    (Type "uint16")
    (Description "Number of columns of bias per amplifier.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.bias" "Imaging Run" "Imaging Run.bias")

  (Attribute "Imaging Run.overscan"
    (Name "overscan")
    (Type "uint16")
    (Description "Number of columns of overscan per amplifier.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Imaging Run.overscan" "Imaging Run" "Imaging Run.overscan")

  (Attribute "Imaging Run.quality"
    (Name "quality")
    (Type "arDataQuality")
    (Description "Mountain estimate of the overall data quality.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Imaging Run.quality" "Imaging Run" "Imaging Run.quality")

  (Operation "Imaging Run.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Imaging Run.c0" "Imaging Run" "Imaging Run.c0")

  (Operation "Imaging Run.zenithDistance"
    (Name "zenithDistance")
    (Description "Return the zenith distance in degrees for the specified field.")
    (Return_Type "float32")
    (Formal_Parameters "uint8 camCol, char filter, uint16 field")
    (Constant "TRUE")
  )
  (Class.Operation "Imaging Run.zenithDistance" "Imaging Run" "Imaging Run.zenithDistance")

  (Operation "Imaging Run.airmass"
    (Name "airmass")
    (Description "Return the airmass for the specified field.")
    (Return_Type "float32")
    (Formal_Parameters "uint8 camCol, char filter, uint16 field")
    (Constant "TRUE")
  )
  (Class.Operation "Imaging Run.airmass" "Imaging Run" "Imaging Run.airmass")

  (Operation "Imaging Run.tcc"
    (Name "tcc")
    (Description "Return the TCC info for the specified field.")
    (Return_Type "arTCCInfo&")
    (Formal_Parameters "uint8 camCol, char filter, uint16 field")
    (Constant "TRUE")
  )
  (Class.Operation "Imaging Run.tcc" "Imaging Run" "Imaging Run.tcc")

  (Association "Imaging Run.Stripe"
    (Multiplicity1 "MANY")
    (Multiplicity2 "OPTIONAL")
    (Container1 "UNI")
    (Friend "TRUE")
  )
  (Class.Association.Class "Imaging Run.Stripe" "Imaging Run" "Stripe")

  (Aggregation "Imaging Run.Field"
    (Multiplicity2 "MANY")
    (Derived "TRUE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Imaging Run.Field" "Imaging Run" "Field")

  (Aggregation "Imaging Run.TCC Info"
    (Multiplicity2 "MANY")
    (Container1 "UNI ooVArray(arTCCInfo)[10]")
    (Static "TRUE")
  )
  (Class.Aggregation.Class "Imaging Run.TCC Info" "Imaging Run" "TCC Info")

  (Generalization "Imaging Run.Product"
  )
  (Class.Generalization.Class "Imaging Run.Product" "Imaging Run" "Product")

  (Attribute "Known Magnitude.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Known Magnitude.filter" "Known Magnitude" "Known Magnitude.filter")

  (Attribute "Known Magnitude.mag"
    (Name "mag")
    (Type "arMag")
    (Size "5")
    (Description "Magnitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Known Magnitude.mag" "Known Magnitude" "Known Magnitude.mag")

  (Attribute "Medium Object Detection.petrosianRadius"
    (Name "petrosianRadius")
    (Document "pixels")
    (Type "arFloatErr")
    (Description "Petrosian radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Medium Object Detection.petrosianRadius" "Medium Object Detection" "Medium Object Detection.petrosianRadius")

  (Attribute "Medium Object Detection.petrosianFlux"
    (Name "petrosianFlux")
    (Document "counts")
    (Type "arFloatErr")
    (Description "Flux within the petrosian radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Medium Object Detection.petrosianFlux" "Medium Object Detection" "Medium Object Detection.petrosianFlux")

  (Attribute "Medium Object Detection.surfaceBrightness"
    (Name "surfaceBrightness")
    (Document "counts/pixel")
    (Type "arFloatErr")
    (Description "Mean surface brightness in pet radius.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Medium Object Detection.surfaceBrightness" "Medium Object Detection" "Medium Object Detection.surfaceBrightness")

  (Generalization "Medium Object Detection.Small Object Detection"
  )
  (Class.Generalization.Class "Medium Object Detection.Small Object Detection" "Medium Object Detection" "Small Object Detection")

  (Association "Merge Run.Frames Pipeline Run"
    (Multiplicity1 "OPTIONAL")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Merge Run.Frames Pipeline Run" "Merge Run" "Frames Pipeline Run")

  (Association "Merge Run.Astrometric Calibration"
    (Multiplicity1 "OPTIONAL")
    (Multiplicity2 "OPTIONAL")
    (Friend "TRUE")
  )
  (Class.Association.Class "Merge Run.Astrometric Calibration" "Merge Run" "Astrometric Calibration")

  (Generalization "Merge Run.Product"
  )
  (Class.Generalization.Class "Merge Run.Product" "Merge Run" "Product")

  (Attribute "MT Calibration.type"
    (Name "type")
    (Document "15")
    (Type "arMTCoefficient")
    (Description "Type of calibration.  e.g., zero-point, extinction, color term, or secondary color term).")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "MT Calibration.type" "MT Calibration" "MT Calibration.type")

  (Attribute "MT Calibration.startTime"
    (Name "startTime")
    (Type "arTime")
    (Description "Beginning of valid time range.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Calibration.startTime" "MT Calibration" "MT Calibration.startTime")

  (Attribute "MT Calibration.endTime"
    (Name "endTime")
    (Type "arTime")
    (Description "End of valid time range.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Calibration.endTime" "MT Calibration" "MT Calibration.endTime")

  (Attribute "MT Calibration.nStars"
    (Name "nStars")
    (Type "uint16")
    (Description "Number of stars used in fit.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Calibration.nStars" "MT Calibration" "MT Calibration.nStars")

  (Aggregation "MT Calibration.Calibration Coefficient"
    (Multiplicity2 "ONE OR MORE")
    (Container1 "ARRAY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "MT Calibration.Calibration Coefficient" "MT Calibration" "Calibration Coefficient")

  (Attribute "MT Detection.counts"
    (Name "counts")
    (Document "counts")
    (Type "arFloatErr")
    (Description "Sky-subtracted counts.  These have been aperture-corrected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Detection.counts" "MT Detection" "MT Detection.counts")

  (Association "MT Detection.MT Exposure"
    (Multiplicity1 "MANY")
  )
  (Class.Association.Class "MT Detection.MT Exposure" "MT Detection" "MT Exposure")

  (Attribute "MT Exposure.filter"
    (Name "filter")
    (Type "char")
    (Description "Filter.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Exposure.filter" "MT Exposure" "MT Exposure.filter")

  (Operation "MT Exposure.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "MT Exposure.c0" "MT Exposure" "MT Exposure.c0")

  (Operation "MT Exposure.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "MT Exposure.c1" "MT Exposure" "MT Exposure.c1")

  (Generalization "MT Exposure.Exposure"
  )
  (Class.Generalization.Class "MT Exposure.Exposure" "MT Exposure" "Exposure")

  (Association "MT Pipeline Plan.MT Sequence"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "MT Pipeline Plan.MT Sequence" "MT Pipeline Plan" "MT Sequence")

  (Attribute "MT Sequence.id"
    (Name "id")
    (Type "uint32")
    (Description "MT sequence number.  This number is unique over the course of the survey.  It is set to the unique DA id for its first frame.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Sequence.id" "MT Sequence" "MT Sequence.id")

  (Attribute "MT Sequence.flavor"
    (Name "flavor")
    (Type "arMTSequenceFlavor")
    (Description "Flavor of this sequence (e.g., dome flat, primary standard, calibration patch, etc).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "MT Sequence.flavor" "MT Sequence" "MT Sequence.flavor")

  (Attribute "MT Sequence.quality"
    (Name "quality")
    (Type "arDataQuality")
    (Description "Mountain estimate of the data quality.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "MT Sequence.quality" "MT Sequence" "MT Sequence.quality")

  (Operation "MT Sequence.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "MT Sequence.c0" "MT Sequence" "MT Sequence.c0")

  (Operation "MT Sequence.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "MT Sequence.c1" "MT Sequence" "MT Sequence.c1")

  (Association "MT Sequence.MT Target"
    (Role2 "target")
    (Multiplicity1 "MANY")
    (Multiplicity2 "OPTIONAL")
    (Container1 "UNI")
    (Friend "TRUE")
  )
  (Class.Association.Class "MT Sequence.MT Target" "MT Sequence" "MT Target")

  (Aggregation "MT Sequence.MT Exposure"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "MT Sequence.MT Exposure" "MT Sequence" "MT Exposure")

  (Generalization "MT Sequence.Product"
  )
  (Class.Generalization.Class "MT Sequence.Product" "MT Sequence" "Product")

  (Attribute "MT Star.col"
    (Name "col")
    (Document "pixels")
    (Type "arFloatErr")
    (Description "Center along columns in primary filter.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Star.col" "MT Star" "MT Star.col")

  (Attribute "MT Star.row"
    (Name "row")
    (Document "pixels")
    (Type "arFloatErr")
    (Description "Center along rows in primary filter.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "MT Star.row" "MT Star" "MT Star.row")

  (Aggregation "MT Star.MT Detection"
    (Multiplicity2 "ONE OR MORE")
    (Container1 "ARRAY")
  )
  (Class.Aggregation.Class "MT Star.MT Detection" "MT Star" "MT Detection")

  (Attribute "MT Star List.quality"
    (Name "quality")
    (Type "arDataQuality")
    (Description "Data quality.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "MT Star List.quality" "MT Star List" "MT Star List.quality")

  (Association "MT Star List.MT Sequence"
    (Multiplicity1 "MANY")
    (Container1 "SECONDARY")
    (Friend "TRUE")
  )
  (Class.Association.Class "MT Star List.MT Sequence" "MT Star List" "MT Sequence")

  (Aggregation "MT Star List.MT Star"
    (Multiplicity2 "MANY")
  )
  (Class.Aggregation.Class "MT Star List.MT Star" "MT Star List" "MT Star")

  (Aggregation "MT Star List.Frame Parameters"
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "MT Star List.Frame Parameters" "MT Star List" "Frame Parameters")

  (Generalization "MT Star List.Product"
  )
  (Class.Generalization.Class "MT Star List.Product" "MT Star List" "Product")

  (Operation "MT Target.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "MT Target.c0" "MT Target" "MT Target.c0")

  (Operation "MT Target.~"
    (Name "~")
    (Description "Required virtual destructor.")
    (Type "VIRTUAL")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "MT Target.~" "MT Target" "MT Target.~")

  (Attribute "Object.id"
    (Name "id")
    (Type "uint16")
    (Description "Object ID, unique within its field.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Object.id" "Object" "Object.id")

  (Attribute "Object.status"
    (Name "status")
    (Type "arObjectStatus")
    (Description "Its status as a survey object (primary, secondary, repeat, undetermined).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Object.status" "Object" "Object.status")

  (Attribute "Object.starLikelyhood"
    (Name "starLikelyhood")
    (Type "float32")
    (Description "Likelihood of object being a star (as determined by photo).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "Object.starLikelyhood" "Object" "Object.starLikelyhood")

  (Attribute "Object.diskLikelihood"
    (Name "diskLikelihood")
    (Document "%")
    (Type "float32")
    (Description "Likelihood of object being a disk galaxy (as determined by photo).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "Object.diskLikelihood" "Object" "Object.diskLikelihood")

  (Attribute "Object.ellipLikelihood"
    (Name "ellipLikelihood")
    (Document "%")
    (Type "float32")
    (Description "Likelihood of object being an elliptical galaxy (as determined by photo).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "Object.ellipLikelihood" "Object" "Object.ellipLikelihood")

  (Attribute "Object.classification"
    (Name "classification")
    (Type "uint8")
    (Description "Morphological classification (galaxy, star), as set by ???")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Object.classification" "Object" "Object.classification")

  (Association "Object.Object"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Mandatory "TRUE")
  )
  (Class.Association.Class "Object.Object" "Object" "Object")

  (Aggregation "Object.Object"
    (Role1 "parent")
    (Multiplicity2 "MANY")
    (Mandatory "TRUE")
  )
  (Class.Aggregation.Class "Object.Object" "Object" "Object")

  (Aggregation "Object.Detection"
    (Multiplicity2 "ONE OR MORE")
    (Container1 "FIXED")
    (Constraint2 "5")
  )
  (Class.Aggregation.Class "Object.Detection" "Object" "Detection")

  (Attribute "Object List.nObjects"
    (Name "nObjects")
    (Type "uint16")
    (Description "Number of objects detected.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Object List.nObjects" "Object List" "Object List.nObjects")

  (Attribute "Object List.nStars"
    (Name "nStars")
    (Type "uint16")
    (Description "Number of objects classified as stars.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Object List.nStars" "Object List" "Object List.nStars")

  (Attribute "Object List.nGalaxies"
    (Name "nGalaxies")
    (Type "uint16")
    (Description "Number of objects classified as galaxies.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Object List.nGalaxies" "Object List" "Object List.nGalaxies")

  (Attribute "Object List.status"
    (Name "status")
    (Type "arFieldStatus")
    (Description "Targeting status (primary, secondary, ignore, undetermined).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Object List.status" "Object List" "Object List.status")

  (Attribute "Object List.quality"
    (Name "quality")
    (Attribute " ")
    (Type "arDataQuality")
    (Description "Data quality of all objects in field.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Object List.quality" "Object List" "Object List.quality")

  (Association "Object List.Field"
    (Multiplicity1 "MANY")
    (Container1 "PRIMARY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Object List.Field" "Object List" "Field")

  (Aggregation "Object List.Corrected Frame"
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "5")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Object List.Corrected Frame" "Object List" "Corrected Frame")

  (Aggregation "Object List.Object"
    (Multiplicity2 "MANY")
    (Container1 "UP2")
  )
  (Class.Aggregation.Class "Object List.Object" "Object List" "Object")

  (Attribute "Object Parameter Value .value"
    (Name "value")
    (Type "ooRef(ooObj)")
    (Description "Link to the object which is the value.")
    (Scope "PRIVATE")
    (Key_Number "0")
  )
  (Class.Attribute "Object Parameter Value .value" "Object Parameter Value " "Object Parameter Value .value")

  (Operation "Object Parameter Value .c1"
    (Name "c1")
    (Description "Construct a new object parameter value, specifying the associated object parameter and a link to the instance value.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LINK<arParameter>& parameter, const LINK<ooObj>& value")
  )
  (Class.Operation "Object Parameter Value .c1" "Object Parameter Value " "Object Parameter Value .c1")

  (Operation "Object Parameter Value .c2"
    (Name "c2")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Object Parameter Value .c2" "Object Parameter Value " "Object Parameter Value .c2")

  (Operation "Object Parameter Value .~"
    (Name "~")
    (Description "Destructor.")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "Object Parameter Value .~" "Object Parameter Value " "Object Parameter Value .~")

  (Operation "Object Parameter Value .value"
    (Name "value")
    (Description "Return the OID of the object which is the parameter value.")
    (Return_Type "const char*")
    (Constant "TRUE")
  )
  (Class.Operation "Object Parameter Value .value" "Object Parameter Value " "Object Parameter Value .value")

  (Generalization "Object Parameter Value .Parameter Value"
  )
  (Class.Generalization.Class "Object Parameter Value .Parameter Value" "Object Parameter Value " "Parameter Value")

  (Attribute "Parameter  .name"
    (Name "name")
    (Type "STRING")
    (Description "Its name, by which it is known to software which uses the parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Parameter  .name" "Parameter  " "Parameter  .name")

  (Attribute "Parameter  .description"
    (Name "description")
    (Type "STRING")
    (Description "A description of the parameter.  This should include units for stored values.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Parameter  .description" "Parameter  " "Parameter  .description")

  (Attribute "Parameter  .dataType"
    (Name "dataType")
    (Type "arParamDataType")
    (Description "The data type of the parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Parameter  .dataType" "Parameter  " "Parameter  .dataType")

  (Operation "Parameter  .c1"
    (Name "c1")
    (Description "Default constructor.  All fields set to blanks.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Parameter  .c1" "Parameter  " "Parameter  .c1")

  (Operation "Parameter  .c2"
    (Name "c2")
    (Description "Construct a parameter, specifying its name, datatype, and a description.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const char* name, arParamDataType dataType, const char* description")
  )
  (Class.Operation "Parameter  .c2" "Parameter  " "Parameter  .c2")

  (Operation "Parameter Value.c1"
    (Name "c1")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Parameter Value.c1" "Parameter Value" "Parameter Value.c1")

  (Operation "Parameter Value.c2"
    (Name "c2")
    (Description "Constructor.  Specify the associated parameter which this instantiates.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LINK<arParameter>& parameter")
  )
  (Class.Operation "Parameter Value.c2" "Parameter Value" "Parameter Value.c2")

  (Operation "Parameter Value.~"
    (Name "~")
    (Description "Destructor.")
    (Type "VIRTUAL")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "Parameter Value.~" "Parameter Value" "Parameter Value.~")

  (Operation "Parameter Value.value"
    (Name "value")
    (Description "Return the parameter value.")
    (Type "ABSTRACT")
    (Return_Type "const char*")
    (Constant "TRUE")
  )
  (Class.Operation "Parameter Value.value" "Parameter Value" "Parameter Value.value")

  (Association "Parameter Value.Parameter  "
    (Role1 "instance")
    (Multiplicity1 "MANY")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Parameter Value.Parameter  " "Parameter Value" "Parameter  ")

  (Attribute "Person .phone"
    (Name "phone")
    (Type "STRING")
    (Description "Phone number.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Person .phone" "Person " "Person .phone")

  (Attribute "Person .lastName"
    (Name "lastName")
    (Type "STRING")
    (Description "Last name.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Person .lastName" "Person " "Person .lastName")

  (Attribute "Person .firstName"
    (Name "firstName")
    (Type "STRING")
    (Description "First name.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Person .firstName" "Person " "Person .firstName")

  (Attribute "Person .email"
    (Name "email")
    (Type "STRING")
    (Description "E-mail address.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Person .email" "Person " "Person .email")

  (Attribute "Person .fax"
    (Name "fax")
    (Type "STRING")
    (Description "Fax number.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Person .fax" "Person " "Person .fax")

  (Operation "Person .c1"
    (Name "c1")
    (Description "Construct a new person, specifying everything.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const char* lastName, const char* firstName, const char* email, const char* phone, const char* fax")
  )
  (Class.Operation "Person .c1" "Person " "Person .c1")

  (Operation "Person .c2"
    (Name "c2")
    (Description "Copy constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arPerson& other")
  )
  (Class.Operation "Person .c2" "Person " "Person .c2")

  (Operation "Person .c3"
    (Name "c3")
    (Description "Default constructor.  Set all fields to blanks.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Person .c3" "Person " "Person .c3")

  (Attribute "Photometric Calibration.startTime"
    (Name "startTime")
    (Attribute "_startTime")
    (Type "VTime")
    (Scope "PRIVATE")
    (Key_Number "0")
  )
  (Class.Attribute "Photometric Calibration.startTime" "Photometric Calibration" "Photometric Calibration.startTime")

  (Attribute "Photometric Calibration.endTime"
    (Name "endTime")
    (Description "Time at which the last observation directly pertaining to this coeeficient was ended.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Calibration.endTime" "Photometric Calibration" "Photometric Calibration.endTime")

  (Association "Photometric Calibration.Frames Pipeline Run"
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Photometric Calibration.Frames Pipeline Run" "Photometric Calibration" "Frames Pipeline Run")

  (Aggregation "Photometric Calibration.Calibration Coefficient"
    (Multiplicity2 "ONE OR MORE")
  )
  (Class.Aggregation.Class "Photometric Calibration.Calibration Coefficient" "Photometric Calibration" "Calibration Coefficient")

  (Generalization "Photometric Calibration.Product"
  )
  (Class.Generalization.Class "Photometric Calibration.Product" "Photometric Calibration" "Product")

  (Attribute "Photometric Transformation.sky"
    (Name "sky")
    (Document "counts/pixel")
    (Type "float32")
    (Description "The average sky value in the frame.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.sky" "Photometric Transformation" "Photometric Transformation.sky")

  (Attribute "Photometric Transformation.skySlope"
    (Name "skySlope")
    (Document "counts/field")
    (Type "float32")
    (Description "The slope in the sky value along the columns.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.skySlope" "Photometric Transformation" "Photometric Transformation.skySlope")

  (Attribute "Photometric Transformation.lbias"
    (Name "lbias")
    (Document "ADUs x TSHIFT")
    (Type "float32")
    (Description "Left-hand bias level.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.lbias" "Photometric Transformation" "Photometric Transformation.lbias")

  (Attribute "Photometric Transformation.rbias"
    (Name "rbias")
    (Document "ADUs x TSHIFT")
    (Type "float32")
    (Description "Right-hand bias level.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.rbias" "Photometric Transformation" "Photometric Transformation.rbias")

  (Attribute "Photometric Transformation.mag20"
    (Name "mag20")
    (Document "counts")
    (Type "float32")
    (Description "Flux corresponding to a 20th magnitude object.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.mag20" "Photometric Transformation" "Photometric Transformation.mag20")

  (Attribute "Photometric Transformation.mag20err"
    (Name "mag20err")
    (Document "counts")
    (Type "float32")
    (Description "Error in mag20.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.mag20err" "Photometric Transformation" "Photometric Transformation.mag20err")

  (Attribute "Photometric Transformation.psfSigX1"
    (Name "psfSigX1")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along rows for inner PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.psfSigX1" "Photometric Transformation" "Photometric Transformation.psfSigX1")

  (Attribute "Photometric Transformation.psfSigX2"
    (Name "psfSigX2")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along rows for outer PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.psfSigX2" "Photometric Transformation" "Photometric Transformation.psfSigX2")

  (Attribute "Photometric Transformation.psfSigY1"
    (Name "psfSigY1")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along columns for inner PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.psfSigY1" "Photometric Transformation" "Photometric Transformation.psfSigY1")

  (Attribute "Photometric Transformation.psfSigY2"
    (Name "psfSigY2")
    (Document "pixels")
    (Type "float32")
    (Description "Gaussian sigma along columns for outer PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.psfSigY2" "Photometric Transformation" "Photometric Transformation.psfSigY2")

  (Attribute "Photometric Transformation.psfB"
    (Name "psfB")
    (Type "float32")
    (Description "Ratio of the inner PSF to the outer PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Photometric Transformation.psfB" "Photometric Transformation" "Photometric Transformation.psfB")

  (Operation "Photometric Transformation.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Photometric Transformation.c0" "Photometric Transformation" "Photometric Transformation.c0")

  (Operation "Photometric Transformation.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Photometric Transformation.c1" "Photometric Transformation" "Photometric Transformation.c1")

  (Association "Photometric Transformation.Frame"
    (Multiplicity1 "MANY")
    (Container1 "PRIMARY")
  )
  (Class.Association.Class "Photometric Transformation.Frame" "Photometric Transformation" "Frame")

  (Attribute "Plan.targetDate"
    (Name "targetDate")
    (Type "TIME")
    (Description "The UT date on which the plan should be carried out.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Plan.targetDate" "Plan" "Plan.targetDate")

  (Operation "Plan.c1"
    (Name "c1")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Plan.c1" "Plan" "Plan.c1")

  (Operation "Plan.c2"
    (Name "c2")
    (Document "const char* comment = \"\"")
    (Source "const TIME& targetDate, const VALINK<arPerson>& authors, ")
    (Description "Constructor.  Specify the associated action, psets to use, plan entries, target date, authors, and an optional comment.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LINK<arAction>& action, const VALINK<arParamValue>& parameterValues, const VALINK<arPlanEntry>& planEntries, ")
  )
  (Class.Operation "Plan.c2" "Plan" "Plan.c2")

  (Operation "Plan.c3"
    (Name "c3")
    (Document "const TIME& creationTime, const char* comment = \"\"")
    (Source "const TIME& targetDate, const VALINK<arPerson>& authors, ")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LINK<arAction>& action, const VALINK<arParamValue>& parameterValues, const VALINK<arPlanEntry>& planEntries, ")
  )
  (Class.Operation "Plan.c3" "Plan" "Plan.c3")

  (Association "Plan.Action"
    (Multiplicity1 "MANY")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Plan.Action" "Plan" "Action")

  (Aggregation "Plan.Plan Entry"
    (Multiplicity2 "MANY")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Plan.Plan Entry" "Plan" "Plan Entry")

  (Aggregation "Plan.Time Stamp"
    (Role2 "created")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Plan.Time Stamp" "Plan" "Time Stamp")

  (Aggregation "Plan.Parameter Value"
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Plan.Parameter Value" "Plan" "Parameter Value")

  (Attribute "Plan Entry.priority"
    (Name "priority")
    (Type "uint16")
    (Description "Execution priority.  1 is highest, then 2, 3, ...")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "Plan Entry.priority" "Plan Entry" "Plan Entry.priority")

  (Operation "Plan Entry.c1"
    (Name "c1")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Plan Entry.c1" "Plan Entry" "Plan Entry.c1")

  (Operation "Plan Entry.c2"
    (Name "c2")
    (Description "Constructor.  Specify the execution priority.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "uint16 priority")
  )
  (Class.Operation "Plan Entry.c2" "Plan Entry" "Plan Entry.c2")

  (Operation "Plan Entry.~"
    (Name "~")
    (Description "Required virtual destructor.")
    (Type "VIRTUAL")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "Plan Entry.~" "Plan Entry" "Plan Entry.~")

  (Attribute "Postage Stamp.pixelMap"
    (Name "pixelMap")
    (Document "ADUs")
    (Type "uint16")
    (Size "841")
    (Description "29x29 pixel subimage.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Postage Stamp.pixelMap" "Postage Stamp" "Postage Stamp.pixelMap")

  (Attribute "Postage Stamp.midRow"
    (Name "midRow")
    (Type "uint32")
    (Description "Frame row of the stamp's middle pixel.  The location is with respect to the data section.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Postage Stamp.midRow" "Postage Stamp" "Postage Stamp.midRow")

  (Attribute "Postage Stamp.midCol"
    (Name "midCol")
    (Type "uint32")
    (Description "Frame column of the stamp's middle pixel.  The location is with respect to the data section.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Postage Stamp.midCol" "Postage Stamp" "Postage Stamp.midCol")

  (Aggregation "Postage Stamp.DA Star"
    (Multiplicity2 "OPTIONAL")
    (Container1 "UP")
  )
  (Class.Aggregation.Class "Postage Stamp.DA Star" "Postage Stamp" "DA Star")

  (Attribute "Postage Stamp Calibration.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "SECONDARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Postage Stamp Calibration.camCol" "Postage Stamp Calibration" "Postage Stamp Calibration.camCol")

  (Attribute "Postage Stamp Calibration.field0"
    (Name "field0")
    (Type "uint16")
    (Description "First field reduced.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Postage Stamp Calibration.field0" "Postage Stamp Calibration" "Postage Stamp Calibration.field0")

  (Operation "Postage Stamp Calibration.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Postage Stamp Calibration.c0" "Postage Stamp Calibration" "Postage Stamp Calibration.c0")

  (Operation "Postage Stamp Calibration.trans"
    (Name "trans")
    (Description "Return the photometric transformation for the specified field.")
    (Return_Type "const arFieldPhotoTrans&")
    (Formal_Parameters "uint16 field")
    (Constant "TRUE")
  )
  (Class.Operation "Postage Stamp Calibration.trans" "Postage Stamp Calibration" "Postage Stamp Calibration.trans")

  (Operation "Postage Stamp Calibration.nFields"
    (Name "nFields")
    (Description "Return the number of fields reduced.")
    (Return_Type "uint16")
    (Constant "TRUE")
  )
  (Class.Operation "Postage Stamp Calibration.nFields" "Postage Stamp Calibration" "Postage Stamp Calibration.nFields")

  (Operation "Postage Stamp Calibration.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Postage Stamp Calibration.c1" "Postage Stamp Calibration" "Postage Stamp Calibration.c1")

  (Aggregation "Postage Stamp Calibration.Flat Field Vector"
    (Multiplicity2 "MANY")
  )
  (Class.Aggregation.Class "Postage Stamp Calibration.Flat Field Vector" "Postage Stamp Calibration" "Flat Field Vector")

  (Aggregation "Postage Stamp Calibration.Photometric Transformation"
    (Multiplicity2 "MANY")
    (Container1 "UP UNI ooVArray(arFieldPhotoTrans)")
    (Static "TRUE")
  )
  (Class.Aggregation.Class "Postage Stamp Calibration.Photometric Transformation" "Postage Stamp Calibration" "Photometric Transformation")

  (Aggregation "Postage Stamp Calibration.Bias Vector"
    (Multiplicity2 "MANY")
  )
  (Class.Aggregation.Class "Postage Stamp Calibration.Bias Vector" "Postage Stamp Calibration" "Bias Vector")

  (Generalization "Postage Stamp Calibration.Product"
  )
  (Class.Generalization.Class "Postage Stamp Calibration.Product" "Postage Stamp Calibration" "Product")

  (Attribute "Postage Stamp Pipeline Plan.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Postage Stamp Pipeline Plan.camCol" "Postage Stamp Pipeline Plan" "Postage Stamp Pipeline Plan.camCol")

  (Generalization "Postage Stamp Pipeline Plan.Plan Entry"
  )
  (Class.Generalization.Class "Postage Stamp Pipeline Plan.Plan Entry" "Postage Stamp Pipeline Plan" "Plan Entry")

  (Attribute "Primary Standard Field.id"
    (Name "id")
    (Type "STRING")
    (Description "Unique identifying name.  Usually this is the name of the brightest standard star in the field.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Primary Standard Field.id" "Primary Standard Field" "Primary Standard Field.id")

  (Attribute "Primary Standard Field.coord"
    (Name "coord")
    (Type "arEquatorialCoord")
    (Description "Equatorial coordinates of the field center.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Primary Standard Field.coord" "Primary Standard Field" "Primary Standard Field.coord")

  (Operation "Primary Standard Field.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Primary Standard Field.c0" "Primary Standard Field" "Primary Standard Field.c0")

  (Operation "Primary Standard Field.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Primary Standard Field.c1" "Primary Standard Field" "Primary Standard Field.c1")

  (Aggregation "Primary Standard Field.Primary Standard Star"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Primary Standard Field.Primary Standard Star" "Primary Standard Field" "Primary Standard Star")

  (Generalization "Primary Standard Field.MT Target"
  )
  (Class.Generalization.Class "Primary Standard Field.MT Target" "Primary Standard Field" "MT Target")

  (Attribute "Primary Standard Star.id"
    (Name "id")
    (Type "STRING")
    (Description "Unique identifying name.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Primary Standard Star.id" "Primary Standard Star" "Primary Standard Star.id")

  (Attribute "Primary Standard Star.coord"
    (Name "coord")
    (Type "arEquatorialCoord")
    (Description "Equatorial coordinates.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Primary Standard Star.coord" "Primary Standard Star" "Primary Standard Star.coord")

  (Operation "Primary Standard Star.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Primary Standard Star.c0" "Primary Standard Star" "Primary Standard Star.c0")

  (Operation "Primary Standard Star.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Primary Standard Star.c1" "Primary Standard Star" "Primary Standard Star.c1")

  (Aggregation "Primary Standard Star.Known Magnitude"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Primary Standard Star.Known Magnitude" "Primary Standard Star" "Known Magnitude")

  (Attribute "Primary Standards Set.id"
    (Name "id")
    (Type "STRING")
    (Description "Primary standards set ID.  It must be unique.  The name identifies the purpose, or type, of this set of standards.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Primary Standards Set.id" "Primary Standards Set" "Primary Standards Set.id")

  (Operation "Primary Standards Set.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Primary Standards Set.c0" "Primary Standards Set" "Primary Standards Set.c0")

  (Operation "Primary Standards Set.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Primary Standards Set.c1" "Primary Standards Set" "Primary Standards Set.c1")

  (Aggregation "Primary Standards Set.Primary Standard Field"
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Primary Standards Set.Primary Standard Field" "Primary Standards Set" "Primary Standard Field")

  (Operation "Product.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Product.c0" "Product" "Product.c0")

  (Operation "Product.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const ooHandle(arPlanEntry)& planEntry")
  )
  (Class.Operation "Product.c1" "Product" "Product.c1")

  (Operation "Product.comment"
    (Name "comment")
    (Operation "comment")
    (Description "Add a comment.")
    (Category "MODIFIER")
    (Return_Type "void")
    (Formal_Parameters "const VALINK<arPerson>& authors, const char* comment")
  )
  (Class.Operation "Product.comment" "Product" "Product.comment")

  (Operation "Product.~"
    (Name "~")
    (Description "Required virtual destructor.")
    (Type "VIRTUAL")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "Product.~" "Product" "Product.~")

  (Association "Product.Plan Entry"
    (Multiplicity1 "MANY")
    (Multiplicity2 "OPTIONAL")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Product.Plan Entry" "Product" "Plan Entry")

  (Aggregation "Product.Time Stamp"
    (Role2 "comment")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Product.Time Stamp" "Product" "Time Stamp")

  (Attribute "Quartile.q1"
    (Name "q1")
    (Document "ADUs x TSHIFT")
    (Type "int32")
    (Description "25th percentile.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Quartile.q1" "Quartile" "Quartile.q1")

  (Attribute "Quartile.q2"
    (Name "q2")
    (Document "ADUs x TSHIFT")
    (Type "int32")
    (Description "50th percentile.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Quartile.q2" "Quartile" "Quartile.q2")

  (Attribute "Quartile.q3"
    (Name "q3")
    (Document "ADUs x TSHIFT")
    (Type "int32")
    (Description "75th percentile.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Quartile.q3" "Quartile" "Quartile.q3")

  (Attribute "Quartile.mode"
    (Name "mode")
    (Document "ADUs x TSHIFT")
    (Type "int32")
    (Description "Mode.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Quartile.mode" "Quartile" "Quartile.mode")

  (Attribute "Radial Bin.meanPixelFlux"
    (Name "meanPixelFlux")
    (Document "counts/pixel")
    (Type "float32")
    (Description "Mean pixel flux in annulus.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "Radial Bin.meanPixelFlux" "Radial Bin" "Radial Bin.meanPixelFlux")

  (Attribute "Radial Bin.medianPixelFlux"
    (Name "medianPixelFlux")
    (Document "counts/pixel")
    (Type "float32")
    (Description "Median pixel flux in annulus.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "Radial Bin.medianPixelFlux" "Radial Bin" "Radial Bin.medianPixelFlux")

  (Attribute "Radial Bin.variance"
    (Name "variance")
    (Document "(counts/pixel)^2")
    (Type "float32")
    (Description "Variance in pixel flux in annulus.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Domain "100")
    (Readable "TRUE")
  )
  (Class.Attribute "Radial Bin.variance" "Radial Bin" "Radial Bin.variance")

  (Operation "Report.isReviewed"
    (Name "isReviewed")
    (Description "Return 1 if this report has been reviewed at least once, else return 0.")
    (Return_Type "int16")
    (Constant "TRUE")
    (Inline "TRUE")
  )
  (Class.Operation "Report.isReviewed" "Report" "Report.isReviewed")

  (Operation "Report.c1"
    (Name "c1")
    (Source "const char* comment = \"\"")
    (Description "Constructor.  Specify the action being reported, the list of psets used, the list of products created, the authors and comment.")
    (Category "CONSTRUCTOR")
    (Return_Type "const VALINK<arPerson>& authors, ")
    (Formal_Parameters "const LINK<arAction>& action, const VALINK<arParamValue>& parameterValues, const VALINK<arProduct>& products, ")
  )
  (Class.Operation "Report.c1" "Report" "Report.c1")

  (Operation "Report.review"
    (Name "review")
    (Description "Review the report.  Specify the authors who reviewed it, along with an optional comment.  A report may be reviewed many times.")
    (Category "MODIFIER")
    (Return_Type "void")
    (Formal_Parameters "const VALINK<arPerson>& authors, const char* comment = \"\"")
  )
  (Class.Operation "Report.review" "Report" "Report.review")

  (Operation "Report.c2"
    (Name "c2")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Report.c2" "Report" "Report.c2")

  (Operation "Report.c3"
    (Name "c3")
    (Source "const TIME& creationTime, const char* comment = \"\"")
    (Description "Constructor.  Specify the action being reported, the list of psets used, the list of products created, its creation time, etc.")
    (Category "CONSTRUCTOR")
    (Return_Type "const VALINK<arPerson>& authors, ")
    (Formal_Parameters "const LINK<arAction>& action, const VALINK<arParamValue>& parameterValues, const VALINK<arProduct>& products, ")
  )
  (Class.Operation "Report.c3" "Report" "Report.c3")

  (Association "Report.Action"
    (Multiplicity1 "MANY")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Report.Action" "Report" "Action")

  (Aggregation "Report.created.Time Stamp"
    (Name "created")
    (Role2 "created")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Report.created.Time Stamp" "Report" "Time Stamp")

  (Aggregation "Report.review.Time Stamp"
    (Name "review")
    (Role2 "review")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Report.review.Time Stamp" "Report" "Time Stamp")

  (Aggregation "Report.Product"
    (Multiplicity2 "MANY")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Report.Product" "Report" "Product")

  (Aggregation "Report.Parameter Value"
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Report.Parameter Value" "Report" "Parameter Value")

  (Attribute "Sector.startLambda"
    (Name "startLambda")
    (Document "degrees")
    (Type "float64")
    (Description "The beginning survey \"longitude\" of the sector.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Sector.startLambda" "Sector" "Sector.startLambda")

  (Attribute "Sector.endLambda"
    (Name "endLambda")
    (Document "degrees")
    (Type "float64")
    (Description "The ending survey \"longitude\" of the sector.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Sector.endLambda" "Sector" "Sector.endLambda")

  (Operation "Sector.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Sector.c0" "Sector" "Sector.c0")

  (Operation "Sector.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Sector.c1" "Sector" "Sector.c1")

  (Aggregation "Sector.Calibration Patch"
    (Multiplicity2 "ONE OR MORE")
    (Constraint2 "6")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Sector.Calibration Patch" "Sector" "Calibration Patch")

  (Association "Selected Field List.Object List"
    (Multiplicity1 "OPTIONAL")
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Selected Field List.Object List" "Selected Field List" "Object List")

  (Association "Selected Field List.Astrometric Calibration"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Selected Field List.Astrometric Calibration" "Selected Field List" "Astrometric Calibration")

  (Association "Selected Field List.Photometric Calibration"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Selected Field List.Photometric Calibration" "Selected Field List" "Photometric Calibration")

  (Generalization "Selected Field List.Product"
  )
  (Class.Generalization.Class "Selected Field List.Product" "Selected Field List" "Product")

  (Attribute "Single Precision Measurement.value"
    (Name "value")
    (Type "o_float")
    (Description "The measured value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Single Precision Measurement.value" "Single Precision Measurement" "Single Precision Measurement.value")

  (Attribute "Single Precision Measurement.variance"
    (Name "variance")
    (Type "o_float")
    (Description "The variance in the measured value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Single Precision Measurement.variance" "Single Precision Measurement" "Single Precision Measurement.variance")

  (Operation "Single Precision Measurement.operator ^(o_float other)"
    (Name "operator ^(o_float other)")
    (Operation "operator^")
    (Return_Type "arFloatErr")
    (Formal_Parameters "o_float other")
  )
  (Class.Operation "Single Precision Measurement.operator ^(o_float other)" "Single Precision Measurement" "Single Precision Measurement.operator ^(o_float other)")

  (Operation "Single Precision Measurement.^'"
    (Name "^'")
    (Operation "operator^")
    (Return_Type "arFloatErr")
    (Formal_Parameters "o_4b other")
  )
  (Class.Operation "Single Precision Measurement.^'" "Single Precision Measurement" "Single Precision Measurement.^'")

  (Operation "Single Precision Measurement.^''"
    (Name "^''")
    (Operation "operator^")
    (Return_Type "arFLoatErr")
    (Formal_Parameters "o_float other")
  )
  (Class.Operation "Single Precision Measurement.^''" "Single Precision Measurement" "Single Precision Measurement.^''")

  (Operation "Single Precision Measurement.slog"
    (Name "slog")
    (Return_Type "arFloatErr")
  )
  (Class.Operation "Single Precision Measurement.slog" "Single Precision Measurement" "Single Precision Measurement.slog")

  (Operation "Single Precision Measurement.sln"
    (Name "sln")
    (Return_Type "arFloatErr")
  )
  (Class.Operation "Single Precision Measurement.sln" "Single Precision Measurement" "Single Precision Measurement.sln")

  (Operation "Single Precision Measurement.err"
    (Name "err")
    (Return_Type "o_float")
  )
  (Class.Operation "Single Precision Measurement.err" "Single Precision Measurement" "Single Precision Measurement.err")

  (Operation "Single Precision Measurement.arFloatErr(o_float value, o_float err=0)"
    (Name "arFloatErr(o_float value, o_float err=0)")
    (Operation "arFloatErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_float value, o_float err=0")
  )
  (Class.Operation "Single Precision Measurement.arFloatErr(o_float value, o_float err=0)" "Single Precision Measurement" "Single Precision Measurement.arFloatErr(o_float value, o_float err=0)")

  (Operation "Single Precision Measurement.arFloatErr(const arFloatErr& other)"
    (Name "arFloatErr(const arFloatErr& other)")
    (Operation "arFloatErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arFloatErr& other")
  )
  (Class.Operation "Single Precision Measurement.arFloatErr(const arFloatErr& other)" "Single Precision Measurement" "Single Precision Measurement.arFloatErr(const arFloatErr& other)")

  (Operation "Single Precision Measurement.arFloatErr"
    (Name "arFloatErr")
    (Operation "arFloatErr")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double value")
  )
  (Class.Operation "Single Precision Measurement.arFloatErr" "Single Precision Measurement" "Single Precision Measurement.arFloatErr")

  (Operation "Single Precision Measurement.set"
    (Name "set")
    (Category "MODIFIER")
    (Formal_Parameters "o_float value, o_float err")
  )
  (Class.Operation "Single Precision Measurement.set" "Single Precision Measurement" "Single Precision Measurement.set")

  (Operation "Single Precision Measurement.*"
    (Name "*")
    (Operation "operator*")
    (Return_Type "arFloatErr")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Single Precision Measurement.*" "Single Precision Measurement" "Single Precision Measurement.*")

  (Operation "Single Precision Measurement.+"
    (Name "+")
    (Operation "operator+")
    (Return_Type "arFloatErr")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Single Precision Measurement.+" "Single Precision Measurement" "Single Precision Measurement.+")

  (Operation "Single Precision Measurement.-"
    (Name "-")
    (Operation "operator-")
    (Return_Type "arFloatErr")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Single Precision Measurement.-" "Single Precision Measurement" "Single Precision Measurement.-")

  (Operation "Single Precision Measurement./"
    (Name "/")
    (Operation "operator/")
    (Return_Type "arFLoatErr")
    (Formal_Parameters "arFloatErr v1, arFloatErr v2")
    (Friend "TRUE")
  )
  (Class.Operation "Single Precision Measurement./" "Single Precision Measurement" "Single Precision Measurement./")

  (Operation "Single Precision Measurement.<<"
    (Name "<<")
    (Operation "operator<<")
    (Return_Type "ostream&")
    (Formal_Parameters "ostream& s, const arFloatErr& value")
    (Friend "TRUE")
  )
  (Class.Operation "Single Precision Measurement.<<" "Single Precision Measurement" "Single Precision Measurement.<<")

  (Operation "Single Precision Measurement.+="
    (Name "+=")
    (Operation "operator+=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "arFloatErr other")
  )
  (Class.Operation "Single Precision Measurement.+=" "Single Precision Measurement" "Single Precision Measurement.+=")

  (Operation "Single Precision Measurement.-="
    (Name "-=")
    (Operation "operator-=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "arFloatErr other")
  )
  (Class.Operation "Single Precision Measurement.-=" "Single Precision Measurement" "Single Precision Measurement.-=")

  (Operation "Single Precision Measurement.*="
    (Name "*=")
    (Operation "operator*=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "arFloatErr other")
  )
  (Class.Operation "Single Precision Measurement.*=" "Single Precision Measurement" "Single Precision Measurement.*=")

  (Operation "Single Precision Measurement./="
    (Name "/=")
    (Operation "operator/=")
    (Category "MODIFIER")
    (Return_Type "arFLoatErr&")
    (Formal_Parameters "arFloatErr other")
  )
  (Class.Operation "Single Precision Measurement./=" "Single Precision Measurement" "Single Precision Measurement./=")

  (Operation "Single Precision Measurement.^="
    (Name "^=")
    (Operation "operator^=")
    (Category "MODIFIER")
    (Return_Type "arFLoatErr&")
    (Formal_Parameters "o_float other")
  )
  (Class.Operation "Single Precision Measurement.^=" "Single Precision Measurement" "Single Precision Measurement.^=")

  (Operation "Single Precision Measurement.^='"
    (Name "^='")
    (Operation "operator^=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "o_4b other")
  )
  (Class.Operation "Single Precision Measurement.^='" "Single Precision Measurement" "Single Precision Measurement.^='")

  (Operation "Single Precision Measurement.^=''"
    (Name "^=''")
    (Operation "operator^=")
    (Category "MODIFIER")
    (Return_Type "arFloatErr&")
    (Formal_Parameters "o_float other")
  )
  (Class.Operation "Single Precision Measurement.^=''" "Single Precision Measurement" "Single Precision Measurement.^=''")

  (Attribute "Small Object Detection.apFlux"
    (Name "apFlux")
    (Document "counts")
    (Type "arFloatErr")
    (Description "Flux in 3 arcsec diameter aperture.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.apFlux" "Small Object Detection" "Small Object Detection.apFlux")

  (Attribute "Small Object Detection.psfFlux"
    (Name "psfFlux")
    (Document "counts")
    (Type "arFloatErr")
    (Description "Flux via fit to the PSF.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.psfFlux" "Small Object Detection" "Small Object Detection.psfFlux")

  (Attribute "Small Object Detection.totalFlux"
    (Name "totalFlux")
    (Document "counts")
    (Type "arFloatErr")
    (Description "Total flux.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.totalFlux" "Small Object Detection" "Small Object Detection.totalFlux")

  (Attribute "Small Object Detection.stoke1"
    (Name "stoke1")
    (Type "float32")
    (Description "First Stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.stoke1" "Small Object Detection" "Small Object Detection.stoke1")

  (Attribute "Small Object Detection.stoke2"
    (Name "stoke2")
    (Type "float32")
    (Description "Second Stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.stoke2" "Small Object Detection" "Small Object Detection.stoke2")

  (Attribute "Small Object Detection.stoke3"
    (Name "stoke3")
    (Type "float32")
    (Description "Third Stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.stoke3" "Small Object Detection" "Small Object Detection.stoke3")

  (Attribute "Small Object Detection.stoke4"
    (Name "stoke4")
    (Type "float32")
    (Description "Fourth Stoke's parameter.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.stoke4" "Small Object Detection" "Small Object Detection.stoke4")

  (Attribute "Small Object Detection.classification"
    (Name "classification")
    (Type "arMorphologicalClassification")
    (Description "Morphological classification.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Bound "TRUE")
  )
  (Class.Attribute "Small Object Detection.classification" "Small Object Detection" "Small Object Detection.classification")

  (Attribute "Small Object Detection.classificationProb"
    (Name "classificationProb")
    (Type "float32")
    (Description "Classification significance.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.classificationProb" "Small Object Detection" "Small Object Detection.classificationProb")

  (Attribute "Small Object Detection.bulgeDisk"
    (Name "bulgeDisk")
    (Type "float32")
    (Description "Bulge/disk ratio.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.bulgeDisk" "Small Object Detection" "Small Object Detection.bulgeDisk")

  (Attribute "Small Object Detection.bulgeDiskProb"
    (Name "bulgeDiskProb")
    (Type "float32")
    (Description "Bulge/disk ratio significance.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Small Object Detection.bulgeDiskProb" "Small Object Detection" "Small Object Detection.bulgeDiskProb")

  (Aggregation "Small Object Detection.Radial Bin"
    (Multiplicity2 "ONE OR MORE")
    (Container1 "HEAP")
    (Constraint2 "ordered")
  )
  (Class.Aggregation.Class "Small Object Detection.Radial Bin" "Small Object Detection" "Radial Bin")

  (Generalization "Small Object Detection.Detection"
  )
  (Class.Generalization.Class "Small Object Detection.Detection" "Small Object Detection" "Detection")

  (Association "Spectroscopic Target.Object"
    (Multiplicity1 "OPTIONAL")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Spectroscopic Target.Object" "Spectroscopic Target" "Object")

  (Attribute "Spherical Coordinate.ra"
    (Name "ra")
    (Document "degrees")
    (Type "float64")
    (Initial_Value "XXX.XXXXXX")
    (Description "Right ascension/longitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Spherical Coordinate.ra" "Spherical Coordinate" "Spherical Coordinate.ra")

  (Attribute "Spherical Coordinate.dec"
    (Name "dec")
    (Document "degrees")
    (Type "float64")
    (Initial_Value "XXX.XXXXXX")
    (Description "Declination/latitude.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Spherical Coordinate.dec" "Spherical Coordinate" "Spherical Coordinate.dec")

  (Operation "Spherical Coordinate.arSphericalCoord(o_double longitude, o_double latitude)"
    (Name "arSphericalCoord(o_double longitude, o_double latitude)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "o_double longitude, o_double latitude")
  )
  (Class.Operation "Spherical Coordinate.arSphericalCoord(o_double longitude, o_double latitude)" "Spherical Coordinate" "Spherical Coordinate.arSphericalCoord(o_double longitude, o_double latitude)")

  (Operation "Spherical Coordinate.arSphericalCoord(const arSphericalCoord& other)"
    (Name "arSphericalCoord(const arSphericalCoord& other)")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arSphericalCoord& other")
  )
  (Class.Operation "Spherical Coordinate.arSphericalCoord(const arSphericalCoord& other)" "Spherical Coordinate" "Spherical Coordinate.arSphericalCoord(const arSphericalCoord& other)")

  (Operation "Spherical Coordinate.set"
    (Name "set")
    (Category "MODIFIER")
    (Formal_Parameters "o_double longitude, o_double latitude")
  )
  (Class.Operation "Spherical Coordinate.set" "Spherical Coordinate" "Spherical Coordinate.set")

  (Operation "Spherical Coordinate.setInRadians"
    (Name "setInRadians")
    (Category "MODIFIER")
    (Formal_Parameters "o_double longitude, o_double latitude")
  )
  (Class.Operation "Spherical Coordinate.setInRadians" "Spherical Coordinate" "Spherical Coordinate.setInRadians")

  (Operation "Spherical Coordinate.setInHoursAndDegrees"
    (Name "setInHoursAndDegrees")
    (Category "MODIFIER")
    (Formal_Parameters "o_double ra, o_double dec")
  )
  (Class.Operation "Spherical Coordinate.setInHoursAndDegrees" "Spherical Coordinate" "Spherical Coordinate.setInHoursAndDegrees")

  (Operation "Spherical Coordinate.distance"
    (Name "distance")
    (Formal_Parameters "const arSphericalCoord& other")
    (Constant "TRUE")
  )
  (Class.Operation "Spherical Coordinate.distance" "Spherical Coordinate" "Spherical Coordinate.distance")

  (Operation "Spherical Coordinate.positionAngle"
    (Name "positionAngle")
    (Formal_Parameters "const arSphericalCoord& other")
    (Constant "TRUE")
  )
  (Class.Operation "Spherical Coordinate.positionAngle" "Spherical Coordinate" "Spherical Coordinate.positionAngle")

  (Operation "Spherical Coordinate.raInHours"
    (Name "raInHours")
    (Constant "TRUE")
  )
  (Class.Operation "Spherical Coordinate.raInHours" "Spherical Coordinate" "Spherical Coordinate.raInHours")

  (Operation "Spherical Coordinate.decInDegrees"
    (Name "decInDegrees")
    (Constant "TRUE")
  )
  (Class.Operation "Spherical Coordinate.decInDegrees" "Spherical Coordinate" "Spherical Coordinate.decInDegrees")

  (Operation "Spherical Coordinate.latitudeInRadians"
    (Name "latitudeInRadians")
    (Constant "TRUE")
  )
  (Class.Operation "Spherical Coordinate.latitudeInRadians" "Spherical Coordinate" "Spherical Coordinate.latitudeInRadians")

  (Operation "Spherical Coordinate.longitudeInRadians"
    (Name "longitudeInRadians")
    (Constant "TRUE")
  )
  (Class.Operation "Spherical Coordinate.longitudeInRadians" "Spherical Coordinate" "Spherical Coordinate.longitudeInRadians")

  (Operation "Spherical Coordinate.<<"
    (Name "<<")
    (Formal_Parameters "ostream& s, const arSphericalCoord& coord")
    (Friend "TRUE")
  )
  (Class.Operation "Spherical Coordinate.<<" "Spherical Coordinate" "Spherical Coordinate.<<")

  (Attribute "SSC Pipeline Plan.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "SSC Pipeline Plan.camCol" "SSC Pipeline Plan" "SSC Pipeline Plan.camCol")

  (Generalization "SSC Pipeline Plan.Plan Entry"
  )
  (Class.Generalization.Class "SSC Pipeline Plan.Plan Entry" "SSC Pipeline Plan" "Plan Entry")

  (Attribute "SSC Pipeline Run.camCol"
    (Name "camCol")
    (Type "uint8")
    (Description "Column in the imaging camera.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "SSC Pipeline Run.camCol" "SSC Pipeline Run" "SSC Pipeline Run.camCol")

  (Attribute "SSC Pipeline Run.field0"
    (Name "field0")
    (Type "uint16")
    (Description "First field reduced.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "SSC Pipeline Run.field0" "SSC Pipeline Run" "SSC Pipeline Run.field0")

  (Operation "SSC Pipeline Run.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "SSC Pipeline Run.c0" "SSC Pipeline Run" "SSC Pipeline Run.c0")

  (Operation "SSC Pipeline Run.c2"
    (Name "c2")
    (Description "Constructor.  The array of star lists should be ordered, starting with field0.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "uint8 camCol, uint16 field0, const VALINK<arSSCStarList>& stars")
  )
  (Class.Operation "SSC Pipeline Run.c2" "SSC Pipeline Run" "SSC Pipeline Run.c2")

  (Operation "SSC Pipeline Run.stars"
    (Name "stars")
    (Description "Return the star list for the specified field.")
    (Return_Type "const ooRef(arSSCStarList)&")
    (Formal_Parameters "uint16 field")
    (Constant "TRUE")
  )
  (Class.Operation "SSC Pipeline Run.stars" "SSC Pipeline Run" "SSC Pipeline Run.stars")

  (Operation "SSC Pipeline Run.nFields"
    (Name "nFields")
    (Description "Return the number of fields reduced.")
    (Return_Type "uint16")
    (Constant "TRUE")
  )
  (Class.Operation "SSC Pipeline Run.nFields" "SSC Pipeline Run" "SSC Pipeline Run.nFields")

  (Aggregation "SSC Pipeline Run.SSC Postage Stamp"
    (Multiplicity2 "MANY")
    (Container1 "UNI ooVArray(ooRef(arSSCStarList))")
    (Static "TRUE")
  )
  (Class.Aggregation.Class "SSC Pipeline Run.SSC Postage Stamp" "SSC Pipeline Run" "SSC Postage Stamp")

  (Generalization "SSC Pipeline Run.Product"
  )
  (Class.Generalization.Class "SSC Pipeline Run.Product" "SSC Pipeline Run" "Product")

  (Association "SSC Postage Stamp.Postage Stamp"
    (Role2 "parent")
    (Multiplicity1 "MANY")
    (Constraint2 "same field, different frame")
  )
  (Class.Association.Class "SSC Postage Stamp.Postage Stamp" "SSC Postage Stamp" "Postage Stamp")

  (Generalization "SSC Postage Stamp.Postage Stamp"
  )
  (Class.Generalization.Class "SSC Postage Stamp.Postage Stamp" "SSC Postage Stamp" "Postage Stamp")

  (Attribute "String Parameter Value .value"
    (Name "value")
    (Type "STRING")
    (Description "The stored value.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Constant "TRUE")
    (Readable "TRUE")
  )
  (Class.Attribute "String Parameter Value .value" "String Parameter Value " "String Parameter Value .value")

  (Operation "String Parameter Value .c1"
    (Name "c1")
    (Description "Construct a new string parameter value, specifying the associated string parameter and the value.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const LINK<arParameter>& parameter, const char* value")
  )
  (Class.Operation "String Parameter Value .c1" "String Parameter Value " "String Parameter Value .c1")

  (Operation "String Parameter Value .c2"
    (Name "c2")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "String Parameter Value .c2" "String Parameter Value " "String Parameter Value .c2")

  (Operation "String Parameter Value .~"
    (Name "~")
    (Description "Destructor.")
    (Category "DESTRUCTOR")
  )
  (Class.Operation "String Parameter Value .~" "String Parameter Value " "String Parameter Value .~")

  (Generalization "String Parameter Value .Parameter Value"
  )
  (Class.Generalization.Class "String Parameter Value .Parameter Value" "String Parameter Value " "Parameter Value")

  (Attribute "Stripe.id"
    (Name "id")
    (Type "int16")
    (Description "Survey stripe identifier.")
    (Scope "PRIVATE")
    (Key "PRIMARY")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Stripe.id" "Stripe" "Stripe.id")

  (Attribute "Stripe.eta"
    (Name "eta")
    (Document "degrees")
    (Type "float64")
    (Initial_Value "XXX.X")
    (Description "Survey \"latitude\" of the stripe.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Stripe.eta" "Stripe" "Stripe.eta")

  (Attribute "Stripe.startLambda"
    (Name "startLambda")
    (Document "degrees")
    (Type "float64")
    (Description "Beginning survey \"longitude\" of the stripe.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Stripe.startLambda" "Stripe" "Stripe.startLambda")

  (Attribute "Stripe.endLambda"
    (Name "endLambda")
    (Document "degrees")
    (Type "float64")
    (Description "Ending survey \"longitude\" of the stripe.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Stripe.endLambda" "Stripe" "Stripe.endLambda")

  (Operation "Stripe.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Stripe.c0" "Stripe" "Stripe.c0")

  (Operation "Stripe.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "Stripe.c1" "Stripe" "Stripe.c1")

  (Aggregation "Stripe.Sector"
    (Multiplicity2 "ONE OR MORE")
    (Container1 "UP")
    (Mandatory "TRUE")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Stripe.Sector" "Stripe" "Sector")

  (Attribute "Survey Coordinate.lambda"
    (Name "lambda")
    (Document "degrees")
    (Type "float64")
    (Description "Survey \"longitude\".")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Survey Coordinate.lambda" "Survey Coordinate" "Survey Coordinate.lambda")

  (Attribute "Survey Coordinate.eta"
    (Name "eta")
    (Document "degrees")
    (Type "float64")
    (Description "Survey \"latitude\".")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Survey Coordinate.eta" "Survey Coordinate" "Survey Coordinate.eta")

  (Attribute "Target List.extras"
    (Name "extras")
    (Type "bool")
    (Description "Have extra targets (i.e., serendipity and stars) been selected yet?")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Class.Attribute "Target List.extras" "Target List" "Target List.extras")

  (Association "Target List.Astrometric Calibration"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Target List.Astrometric Calibration" "Target List" "Astrometric Calibration")

  (Association "Target List.Photometric Calibration"
    (Multiplicity1 "MANY")
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Association.Class "Target List.Photometric Calibration" "Target List" "Photometric Calibration")

  (Association "Target List.Object List"
    (Multiplicity1 "OPTIONAL")
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Target List.Object List" "Target List" "Object List")

  (Aggregation "Target List.Spectroscopic Target"
    (Multiplicity2 "MANY")
    (Friend "TRUE")
  )
  (Class.Aggregation.Class "Target List.Spectroscopic Target" "Target List" "Spectroscopic Target")

  (Generalization "Target List.Product"
  )
  (Class.Generalization.Class "Target List.Product" "Target List" "Product")

  (Attribute "TCC Info.frame"
    (Name "frame")
    (Type "uint16")
    (Description "Frame number.")
    (Scope "IMPLEMENTATION")
    (Key "PRIMARY")
    (Key_Number "0")
  )
  (Class.Attribute "TCC Info.frame" "TCC Info" "TCC Info.frame")

  (Attribute "TCC Info.cpu"
    (Name "cpu")
    (Type "uint8")
    (Description "Image DA cpu which produced the set of frames.")
    (Scope "IMPLEMENTATION")
    (Key "PRIMARY")
    (Key_Number "0")
  )
  (Class.Attribute "TCC Info.cpu" "TCC Info" "TCC Info.cpu")

  (Attribute "TCC Info.tai"
    (Name "tai")
    (Document "seconds")
    (Type "TIME")
    (Initial_Value "XXXXXXXXXX.XX")
    (Description "Number of seconds since Nov 17 1858 0 UT/TAI.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.tai" "TCC Info" "TCC Info.tai")

  (Attribute "TCC Info.coord"
    (Name "coord")
    (Type "arSphericalCoord")
    (Description "Telescope boresight.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.coord" "TCC Info" "TCC Info.coord")

  (Attribute "TCC Info.spa"
    (Name "spa")
    (Document "degrees")
    (Type "float32")
    (Initial_Value "XXX.XXX")
    (Description "Camera col position angle wrt north.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.spa" "TCC Info" "TCC Info.spa")

  (Attribute "TCC Info.ipa"
    (Name "ipa")
    (Document "degrees")
    (Type "float32")
    (Initial_Value "XXX.XXX")
    (Description "Instrument rotator position angle.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.ipa" "TCC Info" "TCC Info.ipa")

  (Attribute "TCC Info.ipaRate"
    (Name "ipaRate")
    (Document "deg/sec")
    (Type "float32")
    (Initial_Value "XXX.XXXX")
    (Description "Instrument rotator angular velocity.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.ipaRate" "TCC Info" "TCC Info.ipaRate")

  (Attribute "TCC Info.az"
    (Name "az")
    (Document "degrees")
    (Type "float32")
    (Initial_Value "XXX.XXXXXX")
    (Description "Azimuth (encoder) of telescope.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.az" "TCC Info" "TCC Info.az")

  (Attribute "TCC Info.alt"
    (Name "alt")
    (Document "degrees")
    (Type "float32")
    (Initial_Value "XXX.XXXXXX")
    (Description "Altitude (encoder) of telescope.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.alt" "TCC Info" "TCC Info.alt")

  (Attribute "TCC Info.focus"
    (Name "focus")
    (Document "microns")
    (Type "float32")
    (Description "Focus position (encoder).")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "TCC Info.focus" "TCC Info" "TCC Info.focus")

  (Operation "TCC Info.c0"
    (Name "c0")
    (Description "Default constructor.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "TCC Info.c0" "TCC Info" "TCC Info.c0")

  (Operation "TCC Info.c1"
    (Name "c1")
    (Description "Constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "AUTO")
  )
  (Class.Operation "TCC Info.c1" "TCC Info" "TCC Info.c1")

  (Attribute "Time Stamp.creationTime"
    (Name "creationTime")
    (Document "TAI")
    (Type "TIME")
    (Description "The time which this stamp records.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Time Stamp.creationTime" "Time Stamp" "Time Stamp.creationTime")

  (Attribute "Time Stamp.comment"
    (Name "comment")
    (Type "STRING")
    (Description "An optional comment.")
    (Scope "PRIVATE")
    (Key_Number "0")
    (Readable "TRUE")
  )
  (Class.Attribute "Time Stamp.comment" "Time Stamp" "Time Stamp.comment")

  (Operation "Time Stamp.c1"
    (Name "c1")
    (Description "Construct a time stamp for now.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const VALINK<arPerson>& authors, const char* comment = \"\"")
  )
  (Class.Operation "Time Stamp.c1" "Time Stamp" "Time Stamp.c1")

  (Operation "Time Stamp.c2"
    (Name "c2")
    (Description "Construct a time stamp for the specified time.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const VALINK<arPerson>& authors, const TIME& time, const char* comment = \"\"")
  )
  (Class.Operation "Time Stamp.c2" "Time Stamp" "Time Stamp.c2")

  (Operation "Time Stamp.c3"
    (Name "c3")
    (Description "Default constructor.  No attributes are set.")
    (Category "CONSTRUCTOR")
  )
  (Class.Operation "Time Stamp.c3" "Time Stamp" "Time Stamp.c3")

  (Operation "Time Stamp.c4"
    (Name "c4")
    (Description "Copy constructor.")
    (Category "CONSTRUCTOR")
    (Formal_Parameters "const arStamp& other")
  )
  (Class.Operation "Time Stamp.c4" "Time Stamp" "Time Stamp.c4")

  (Association "Time Stamp.Person "
    (Role2 "author")
    (Multiplicity1 "MANY")
    (Multiplicity2 "ONE OR MORE")
    (Friend "TRUE")
  )
  (Class.Association.Class "Time Stamp.Person " "Time Stamp" "Person ")

  (Attribute "Excalibur Run Pset.extinctionPeriod"
    (Name "extinctionPeriod")
    (Key_Number "0")
    (Readable "TRUE")
    (Writeable "TRUE")
  )
  (Object.Attribute "Excalibur Run Pset.extinctionPeriod" "Excalibur Run Pset" "Excalibur Run Pset.extinctionPeriod")

  (Link "Administration.Action"
  )
  (Subsystem.Contains.Class "Administration.Action" "Administration" "Action")

  (Link "Administration.Object Parameter Value "
  )
  (Subsystem.Contains.Class "Administration.Object Parameter Value " "Administration" "Object Parameter Value ")

  (Link "Administration.Parameter  "
  )
  (Subsystem.Contains.Class "Administration.Parameter  " "Administration" "Parameter  ")

  (Link "Administration.Parameter Value"
  )
  (Subsystem.Contains.Class "Administration.Parameter Value" "Administration" "Parameter Value")

  (Link "Administration.Person "
  )
  (Subsystem.Contains.Class "Administration.Person " "Administration" "Person ")

  (Link "Administration.Plan"
  )
  (Subsystem.Contains.Class "Administration.Plan" "Administration" "Plan")

  (Link "Administration.Plan Entry"
  )
  (Subsystem.Contains.Class "Administration.Plan Entry" "Administration" "Plan Entry")

  (Link "Administration.Report"
  )
  (Subsystem.Contains.Class "Administration.Report" "Administration" "Report")

  (Link "Administration.String Parameter Value "
  )
  (Subsystem.Contains.Class "Administration.String Parameter Value " "Administration" "String Parameter Value ")

  (Link "Administration.Time Stamp"
  )
  (Subsystem.Contains.Class "Administration.Time Stamp" "Administration" "Time Stamp")

  (Interaction "AP Check In.Astrometric Calibrations"
    (Create "TRUE")
  )
  (Process.Interaction.Data_Store "AP Check In.Astrometric Calibrations" "AP Check In" "Astrometric Calibrations")

  (Interaction "FP Check In.Atlas Images"
    (Create "TRUE")
  )
  (Process.Interaction.Data_Store "FP Check In.Atlas Images" "FP Check In" "Atlas Images")

  (Interaction "FP Check In.Object Lists"
    (Create "TRUE")
  )
  (Process.Interaction.Data_Store "FP Check In.Object Lists" "FP Check In" "Object Lists")

  (Interaction "FP Check In.Objects"
    (Create "TRUE")
  )
  (Process.Interaction.Data_Store "FP Check In.Objects" "FP Check In" "Objects")

  (Interaction "Merge Objects.Atlas Images"
    (Read "TRUE")
  )
  (Process.Interaction.Data_Store "Merge Objects.Atlas Images" "Merge Objects" "Atlas Images")

  (Interaction "Merge Objects.x,y.Objects"
    (Name "x,y")
    (Read "TRUE")
  )
  (Process.Interaction.Data_Store "Merge Objects.x,y.Objects" "Merge Objects" "Objects")

  (Interaction "Merge Objects.Astrometric Calibrations"
    (Read "TRUE")
  )
  (Process.Interaction.Data_Store "Merge Objects.Astrometric Calibrations" "Merge Objects" "Astrometric Calibrations")

  (Interaction "Set Status.x,y,matches.Objects"
    (Name "x,y,matches")
  )
  (Process.Interaction.Data_Store "Set Status.x,y,matches.Objects" "Set Status" "Objects")

  (Interaction "Set Status.status.Objects"
    (Name "status")
  )
  (Process.Interaction.Data_Store "Set Status.status.Objects" "Set Status" "Objects")

  (Data_Flow "Astrometric Pipeline.AP Check In"
    (Instances "TRUE")
    (Transient "TRUE")
  )
  (Actor.Data_Flow.Process "Astrometric Pipeline.AP Check In" "Astrometric Pipeline" "AP Check In")

  (Data_Flow "Frames Pipeline.FP Check In"
    (Instances "TRUE")
    (Transient "TRUE")
  )
  (Actor.Data_Flow.Process "Frames Pipeline.FP Check In" "Frames Pipeline" "FP Check In")

  (Operation "FPR: Checked In.set mergeRun = NULL"
    (Name "set mergeRun = NULL")
  )
  (State.Operation "FPR: Checked In.set mergeRun = NULL" "FPR: Checked In" "FPR: Checked In.set mergeRun = NULL")

  (Event "FPR: Checked In.merge.FPR: Merged"
    (Name "merge")
    (Guard "framesPipelineRun.merged == FALSE")
    (Priority_Number "0")
    (Description "Merge objects for a frames pipeline run with other previously merged objects in the database.")
  )
  (State.Event.State "FPR: Checked In.merge.FPR: Merged" "FPR: Checked In" "FPR: Merged")

  (Operation "FPR: Merged.set mergeRun"
    (Name "set mergeRun")
  )
  (State.Operation "FPR: Merged.set mergeRun" "FPR: Merged" "FPR: Merged.set mergeRun")

  (Operation "O: Checked In.set status = UNDETERMINED"
    (Name "set status = UNDETERMINED")
  )
  (State.Operation "O: Checked In.set status = UNDETERMINED" "O: Checked In" "O: Checked In.set status = UNDETERMINED")

  (Operation "O: Checked In.set target = NULL"
    (Name "set target = NULL")
  )
  (State.Operation "O: Checked In.set target = NULL" "O: Checked In" "O: Checked In.set target = NULL")

  (Operation "O: Checked In.set matches = NULL"
    (Name "set matches = NULL")
  )
  (State.Operation "O: Checked In.set matches = NULL" "O: Checked In" "O: Checked In.set matches = NULL")

  (Event "O: Checked In.merge.O: Merged"
    (Name "merge")
    (Priority_Number "0")
  )
  (State.Event.State "O: Checked In.merge.O: Merged" "O: Checked In" "O: Merged")

  (Operation "O: Merged.set matches"
    (Name "set matches")
  )
  (State.Operation "O: Merged.set matches" "O: Merged" "O: Merged.set matches")

  (Generalization "O: Merged.O: Repeat"
  )
  (State.Substate.State "O: Merged.O: Repeat" "O: Merged" "O: Repeat")

  (Generalization "O: Merged.O: Non-Repeat"
  )
  (State.Substate.State "O: Merged.O: Non-Repeat" "O: Merged" "O: Non-Repeat")

  (Event "O: Non-Repeat.select.O: Selected"
    (Name "select")
    (Priority_Number "0")
  )
  (State.Event.State "O: Non-Repeat.select.O: Selected" "O: Non-Repeat" "O: Selected")

  (Operation "O: Primary.set status = PRIMARY"
    (Name "set status = PRIMARY")
  )
  (State.Operation "O: Primary.set status = PRIMARY" "O: Primary" "O: Primary.set status = PRIMARY")

  (Event "O: Primary.target.O: Targeted"
    (Name "target")
    (Priority_Number "0")
  )
  (State.Event.State "O: Primary.target.O: Targeted" "O: Primary" "O: Targeted")

  (Operation "O: Repeat.set status = REPEAT"
    (Name "set status = REPEAT")
  )
  (State.Operation "O: Repeat.set status = REPEAT" "O: Repeat" "O: Repeat.set status = REPEAT")

  (Operation "O: Secondary.set status = SECONDARY"
    (Name "set status = SECONDARY")
  )
  (State.Operation "O: Secondary.set status = SECONDARY" "O: Secondary" "O: Secondary.set status = SECONDARY")

  (Generalization "O: Selected.O: Secondary"
  )
  (State.Substate.State "O: Selected.O: Secondary" "O: Selected" "O: Secondary")

  (Generalization "O: Selected.O: Primary"
  )
  (State.Substate.State "O: Selected.O: Primary" "O: Selected" "O: Primary")

  (Operation "O: Targeted.set target"
    (Name "set target")
  )
  (State.Operation "O: Targeted.set target" "O: Targeted" "O: Targeted.set target")

  (Operation "OL: Checked In.set status = UNDETERMINED"
    (Name "set status = UNDETERMINED")
  )
  (State.Operation "OL: Checked In.set status = UNDETERMINED" "OL: Checked In" "OL: Checked In.set status = UNDETERMINED")

  (Operation "OL: Checked In.set selectedFieldList = NULL"
    (Name "set selectedFieldList = NULL")
  )
  (State.Operation "OL: Checked In.set selectedFieldList = NULL" "OL: Checked In" "OL: Checked In.set selectedFieldList = NULL")

  (Operation "OL: Checked In.set targetList = NULL"
    (Name "set targetList = NULL")
  )
  (State.Operation "OL: Checked In.set targetList = NULL" "OL: Checked In" "OL: Checked In.set targetList = NULL")

  (Event "OL: Checked In.merge.OL: Merged"
    (Name "merge")
    (Priority_Number "0")
  )
  (State.Event.State "OL: Checked In.merge.OL: Merged" "OL: Checked In" "OL: Merged")

  (Event "OL: Merged.select.OL: Selected"
    (Name "select")
    (Priority_Number "0")
  )
  (State.Event.State "OL: Merged.select.OL: Selected" "OL: Merged" "OL: Selected")

  (Operation "OL: Primary.set status = PRIMARY"
    (Name "set status = PRIMARY")
  )
  (State.Operation "OL: Primary.set status = PRIMARY" "OL: Primary" "OL: Primary.set status = PRIMARY")

  (Event "OL: Primary.target.OL: Targeted"
    (Name "target")
    (Priority_Number "0")
    (Description "Select spectroscopic targets.")
  )
  (State.Event.State "OL: Primary.target.OL: Targeted" "OL: Primary" "OL: Targeted")

  (Operation "OL: Secondary.set status = SECONDARY"
    (Name "set status = SECONDARY")
  )
  (State.Operation "OL: Secondary.set status = SECONDARY" "OL: Secondary" "OL: Secondary.set status = SECONDARY")

  (Operation "OL: Selected.set selectedFieldList"
    (Name "set selectedFieldList")
  )
  (State.Operation "OL: Selected.set selectedFieldList" "OL: Selected" "OL: Selected.set selectedFieldList")

  (Generalization "OL: Selected.OL: Secondary"
  )
  (State.Substate.State "OL: Selected.OL: Secondary" "OL: Selected" "OL: Secondary")

  (Generalization "OL: Selected.OL: Primary"
  )
  (State.Substate.State "OL: Selected.OL: Primary" "OL: Selected" "OL: Primary")

  (Operation "OL: Targeted.set targetList"
    (Name "set targetList")
  )
  (State.Operation "OL: Targeted.set targetList" "OL: Targeted" "OL: Targeted.set targetList")

)

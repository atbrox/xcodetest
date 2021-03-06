# Makefile to build the XcodeTest static library and sample test project

default: clean xcodetest

.PHONY: clean
clean:
	xcodebuild -sdk iphonesimulator -scheme XcodeTest clean
	rm -rf libXcodeTest.a

.PHONY: xcodetest
xcodetest:
	xcodebuild -sdk iphonesimulator -scheme XcodeTest install

.PHONY: bundle
bundle: xcodetest
	zip -r xcodetest.zip libXcodeTest.a build_and_run_unit_tests.sh README.markdown

ui:
	xcodebuild -sdk iphonesimulator -scheme XcodeTestSamplePassingTests build ONLY_ACTIVE_ARCH=NO TEST_AFTER_BUILD=YES

logic:
	xcodebuild -sdk iphonesimulator -scheme XcodeTestSampleLogicTests build ONLY_ACTIVE_ARCH=NO TEST_AFTER_BUILD=YES

passing:
	xcodebuild -sdk iphonesimulator -scheme XcodeTestSamplePassingTests build ONLY_ACTIVE_ARCH=NO TEST_AFTER_BUILD=YES XCODETEST=YES

failing:
	xcodebuild -sdk iphonesimulator -scheme XcodeTestSampleFailingTests build ONLY_ACTIVE_ARCH=NO TEST_AFTER_BUILD=YES XCODETEST=YES

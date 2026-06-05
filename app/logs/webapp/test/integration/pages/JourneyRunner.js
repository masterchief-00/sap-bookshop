sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/logs/test/integration/pages/LogsList",
	"ns/logs/test/integration/pages/LogsObjectPage"
], function (JourneyRunner, LogsList, LogsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/logs') + '/test/flp.html#app-preview',
        pages: {
			onTheLogsList: LogsList,
			onTheLogsObjectPage: LogsObjectPage
        },
        async: true
    });

    return runner;
});


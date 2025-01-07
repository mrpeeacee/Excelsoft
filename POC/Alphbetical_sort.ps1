# Define an array of strings
$strings = @(
"TestPrepAdmin"
"Workflow"
"AdvanceWorkflow"
"AdvanceAuthoring"
"ExamManagement"
"EMS"
"ReportInterface"
"MoE-TestPlayer"
"eLCInvigilator"
"LCInvigilatorManagementApi"
"ExcelImport"
"WebTestAPI"
"DataContainerView"
"eLCTryOut"
"ETLDashboardApplication"
"DataAnalytics"
"DataAnalyticsWebApi"
"eOralWebAPI"
"eORAL"
"eORALTryOut"
"ExamManagementWebApi"
"MoE-TestDeliveryAPI"
"AuthoringApi"
"FrameworkAPI"
"TestWorkflowWebApi"
"AdministrationWebApi"
"LCManagementApi"
"TransferService"
"DataContainerViewAPI"
"TransferServiceAPI"
"ETLDashBoardAPI"
"DataAnalyticsApi"
"ClientInfoForExamCentreReadiness"
"eOralAppAPI"
"WebTestAPP"
"eExam2IntegrationAPI"
)

# Sort the strings in alphabetical order
$sortedStrings = $strings | Sort-Object

# Output the sorted strings
$sortedStrings

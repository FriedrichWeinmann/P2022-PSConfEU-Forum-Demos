@{
	Version = 1
	Tree    = @{
		'LoggingProvider.logfile.FromConfig.Enabled' = $true
		'PSFramework.Logging.LogFile.FromConfig'     = @{
			CsvDelimiter  = ','
			Encoding      = 'UTF8'
			FilePath      = 'C:\Sessions\PSConf.Logging\PSConf-%date%.csv'
			FileType      = 'CSV'
			Headers       = @('Timestamp', 'Level', 'Message', 'FunctionName', 'ModuleName', 'File', 'Line', 'Runspace', 'Tags', 'TargetObject')
			IncludeHeader = $true
			TimeFormat    = 'yyyy-MM-dd HH:mm:ss.fff'
			UTC           = $true
		}
	}
}
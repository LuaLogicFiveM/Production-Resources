---@class SocietyTransactionData
---@field id number? -- if not provided, it will be auto-generated
---@field society_name string
---@field type 'deposit' | 'withdraw' | 'bonus'
---@field amount number
---@field identifier string
---@field performed_by string
---@field createdAt? string



-- Employee Data
---@class DutyDataProps
---@field date string  
---@field time number  
---@
---@class jobPlayerVehicles
---@field id number
---@field vehicleLabel string
---@field vehiclePlate string
---@
---@class EmployeeData
---@field identifier string
---@field name string
---@field grade_name string
---@field job string
---@field grade number
---@field isOnDuty boolean|nil     
---@field dailyDutyData? DutyDataProps[]|nil 
---@field total_time? number|nil      
---@field last_clock_in? number | string| nil 
---@field sex string
---@field isOnLeave boolean|nil      
---@field jobPlayerVehicles? jobPlayerVehicles[]|nil


---@class BossPlayerReport
---@field id number
---@field name string
---@field identifier string
---@field job string
---@field grade_label string
---@field report_text string
---@field status 'pending' | 'in_progress' | 'resolved'
---@field created_at string
---@field updated_at string
---@field boss_notes any
---@field evidence string[]


---@class JobApplicationSubmission
---@field id string
---@field identifier string
---@field name string
---@field status 'pending' | 'approved' | 'rejected' | 'pending_review'
---@field created_at string
---@field application_data any
---@field reviewed_by string
---@field reviewed_at string
---@field notes string
---@

---@class EmployeeLeave
---@field id number
---@field identifier string
---@field name string
---@field job string
---@field grade_label string
---@field status 'pending' | 'approved' | 'rejected' | 'pending_review'
---@field created_at string
---@field updated_at string
---@field notes string
---@field start_date string
---@field end_date string
---@field total_days number
---@field reason string
---@field leave_type string
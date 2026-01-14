return {
    -- Command to create announcements
    Command = "announce",

    -- Default duration of announcements (in seconds)
    DefaultDuration = 10,

    -- Jobs table name (change if your server uses a different table name)
    JobsTableName = "jobs",

    -- Cache duration for jobs in milliseconds (5 minutes = 300000)
    JobsCacheDuration = 300000,

    -- Enable/Disable categories system
    EnableCategories = true,

    -- Enable/Disable duration selection
    EnableDurationSelection = true,

    -- Enable/Disable visibility selection
    EnableVisibilitySelection = true,

    -- Available duration options (only if EnableDurationSelection = true)
    DurationOptions = {
        { value = 5, text = "5 seconds" },
        { value = 10, text = "10 seconds" },
        { value = 15, text = "15 seconds" },
        { value = 20, text = "20 seconds" },
        { value = 30, text = "30 seconds" }
    },

    Texts = {
        -- Interface texts
        Interface = {
            CreateTitle = "Create Announcement",
            CreateSubtitle = "Publish your announcement for the entire city",
            JobPermissionsVerified = "Permissions verified",
            CategoryLabel = "Announcement Category (Optional)",
            CategoryNamePlaceholder = "Ex: My Business",
            CategoryColorLabel = "Color:",
            CategoryPreview = "Preview",
            ContentLabel = "Announcement Content",
            ContentPlaceholder = "Write your announcement content here...",
            DurationLabel = "Announcement Duration",
            VisibilityLabel = "Announcement Visibility",
            CancelButton = "Cancel",
            PublishButton = "Publish Announcement",
            PublishingButton = "Publishing...",
            PreviewTitle = "Preview",
            PreviewContent = "The announcement content will appear here...",
            DurationInfo = "Duration: %s",
            VisibilityAll = "Visible to everyone",
            VisibilityJob = "Only my team",
            GPSButtonText = "Mark on GPS"
        },

        -- Server notifications
        Notifications = {
            NoPermission = "You don't have permission to make announcements.",
            NoContent = "You haven't entered content for the announcement.",
            PublishSuccess = "Announcement%s published for %s.",
            PublishSuccessWithCategory = " with category \"%s\"",
            VisibilityAll = "all players",
            VisibilityJob = "your work team",
            FilterUsage = "Usage: /filterannounce [category]",
            CategoryNotFound = "Category not found.",
            FilterApplied = "Filter applied: %s"
        },

        -- Client notifications (GPS)
        GPS = {
            AlreadyMarked = "You have already marked it on the GPS previously.",
            LocationMarked = "Location marked on GPS.",
            KeyMappingDescription = "Mark announcement location on GPS"
        }
    },

    Announces = {
        owner = {
            name = "Owner",
            image = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png" 
        },
        manager = {
            name = "Manager",
            image = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png" 
        },
        admin = {
            name = "Admin",
            image = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png" 
        },
        mod = {
            name = "Mod",
            image = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png" 
        },
    }
}
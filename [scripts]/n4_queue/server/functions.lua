---@class PrioRow
---@field points number
---@field category? string

---Fetches every row of prio a user has in the database that is associated with one or more of their identifiers. The "identifiers" parameter that is passed to this function is a string array of all of the users available identifiers. For example: {"steam:12345", "discord:123445", "license:12345"}. The value you return must be an array of the "PrioRow" type where points is a required number and category is an optional string, although you should add a category to identify what every row of prio is for. An example of what that would look like is: { { points = 5000, category = 'Label Here' }, { points = 1000 }, { points = 2500, category = 'Label Here' } }
---@param identifiers string[]
---@return PrioRow[]
function FetchUserDatabasePrio(identifiers)
    --if using mysql, you dont have to touch this, it will work out of the box. This function is only here to provide support for servers using other databases or those who have pre-existing queue tables with different column names.

    local rows = MySQL and MySQL.Sync.fetchAll(
        'SELECT points, category FROM queue WHERE identifier IN (?)',
        { identifiers }
    ) or {}

    return rows
end

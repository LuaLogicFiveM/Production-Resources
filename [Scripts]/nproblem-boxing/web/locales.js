const locales = {
    en: {
        managementText: "Management",
        dashboardText: "Dashboard",
        greetingsText: "Greetings",
        companyBalance: "Company Balance",
        transactionHistoryText: "Transaction History",
        upcomingMatchesHeader: "Upcoming Matches",
        addFunds: "Add Funds",
        withdrawFunds: "Withdraw Funds",
        enterAmount: "Enter amount",
        workerManagement: "Worker Management",
        scheduleText: "Schedule",
        scheduledMatchPlan: "Match Planning & Scheduled Matches",
        blacklistPlayers: "Blacklist",
        exitText: "Exit",
        matchListHeaderBoxers: "Boxers",
        matchListHeaderTime: "Time",
        transHeaderType: "Type",
        transHeaderAmount: "Amount",
        transHeaderDate: "Date",
        transHeaderTransactionType: "Transaction Type",
        transHeaderMadedBy: "Made By",
        manageEmployees: "Manage Employees",
        hireNewEmployee: "Hire New Employee",
        empHeaderName: "Employee Name",
        empHeaderHiredBy: "Hired By",
        empHeaderSince: "Working Since",
        scheduleHeaderPlannedBy: "Planned By",
        scheduleHeaderBoxer1: "Boxer",
        scheduleHeaderBoxer2: "Boxer",
        scheduleHeaderRounds: "Rounds",
        scheduleHeaderWinPool: "Win Pool",
        scheduleHeaderDate: "Match Date",
        scheduleHeaderBets: "Bets",
        planNewMatch: "Plan New Match",
        blacklistHeaderTitle: "Blacklist",
        addBlacklist: "Add Blacklist",
        blHeaderBy: "Blacklisted By",
        blHeaderName: "Name",
        blHeaderDate: "Date",
        blHeaderReason: "Reason",
    }
};

window.onload = function () {
    const lang = "en";
    const texts = locales[lang];

    for (const id in texts) {
        const element = document.getElementById(id);
        if (element) {
            if (element.tagName === "INPUT" && element.placeholder) {
                element.placeholder = texts[id];
            } else {
                element.innerText = texts[id];
            }
        }
    }

    document.querySelectorAll("th").forEach(th => {
        switch (th.innerText.trim()) {
            case "Type": th.innerText = texts.transHeaderType; break;
            case "Amount": th.innerText = texts.transHeaderAmount; break;
            case "Date": th.innerText = texts.transHeaderDate; break;
            case "Transaction Type": th.innerText = texts.transHeaderTransactionType; break;
            case "Maded By": th.innerText = texts.transHeaderMadedBy; break;
            case "Boxers": th.innerText = texts.matchListHeaderBoxers; break;
            case "Time": th.innerText = texts.matchListHeaderTime; break;
            case "Employee Name": th.innerText = texts.empHeaderName; break;
            case "Hired By": th.innerText = texts.empHeaderHiredBy; break;
            case "Working Since": th.innerText = texts.empHeaderSince; break;
            case "Planned By": th.innerText = texts.scheduleHeaderPlannedBy; break;
            case "Boxer": 
                if (!th.dataset.checked) {
                    th.innerText = texts.scheduleHeaderBoxer1;
                    th.dataset.checked = true;
                } else {
                    th.innerText = texts.scheduleHeaderBoxer2;
                }
                break;
            case "Rounds": th.innerText = texts.scheduleHeaderRounds; break;
            case "Win Pool": th.innerText = texts.scheduleHeaderWinPool; break;
            case "Match Date": th.innerText = texts.scheduleHeaderDate; break;
            case "Bets": th.innerText = texts.scheduleHeaderBets; break;
            case "Blacklisted By": th.innerText = texts.blHeaderBy; break;
            case "Name": th.innerText = texts.blHeaderName; break;
            case "Reason": th.innerText = texts.blHeaderReason; break;
        }
    });
};

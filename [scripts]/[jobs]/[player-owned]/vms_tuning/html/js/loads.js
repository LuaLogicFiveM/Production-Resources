const formatDate = (timestamp) => {
    const date = new Date((Number(timestamp) * 1000));
    let hour = date.getHours();
    let minute = date.getMinutes();
    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();
    if (hour < 10) hour = '0' + hour
    if (minute < 10) minute = '0' + minute
    if (day < 10) day = '0' + day
    if (month < 10) month = '0' + month
    
    return day + '.' + month + '.' + year + ' ' + hour + ':' + minute
};

loadAnnoucements = (announcements) => {
    let announcementsData = ''
    for (const [k, v] of Object.entries(announcements)) {
        if (v) {
            announcementsData = announcementsData + `
                <div>
                    <div class="user">
                        <div class="avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="name">${v.name}</div>
                    </div>
                    <div class="message">${v.message}</div>
                </div>
            `
        }
    }
    return announcementsData;
}

loadMissions = (missions) => {
    let missionsData = ''
    for (const [k, v] of Object.entries(missions)) {
        missionsData = missionsData + `
            <tr>
                <td class="table-first"><img src="peds/${v.image}.webp"> ${v.name}</td>
                <td>${v.reward}${translation.currency}</td>
                <td class="table-last"><div onclick="collectMission({
                    id:${Number(k) + 1},
                    name:'${v.name}',
                    npcModel:'${v.npcModel}',
                    reward:${v.reward},
                    missionId:${v.missionId},
                    npcId:${v.npcId},
                })">${translation.missions.accept_button}</div></td>
            </tr>
        `
    }
    return missionsData;
}

loadDiscountCodes = (discountCodes) => {
    let codesData = ''
    for (const [k, v] of Object.entries(discountCodes)) {
        codesData = codesData + `
            <tr>
                <td class="table-first">${v.code}</td>
                <td>${v.percentage}${translation.percentage}</td>
                <td>${v.count}${translation.quantity}</td>
                <td class="table-last">
                    <div class="copy-code" onclick="copyToClipboard('${v.code}', this)">${translation.discounts.copycode_button}</div>
                </td>
            </tr>
        `
    }
    return codesData;
}

loadDiscountCodesGenerator = () => {
    let percentages = ``;
    discountCodesPercentages.forEach((percentage) => percentages += `<div data-percentage="${percentage}" onclick="selectPercentage(this)">${percentage}${translation.percentage}</div>`);
    
    let counts = ``;
    discountCodesUsablesCount.forEach((count) => counts += `<div data-count="${count}" onclick="selectCount(this)">${count}${translation.quantity}</div>`);
    
    return {codesPercentages: percentages, codesCounts: counts};
}

loadEmployees = (employees) => {
    let employeesData = ''
    for (const [k, v] of Object.entries(employees)) {
        employeesData = employeesData + `
            <tr>
                <td class="table-first">${v.name}</td>
                <td>${v.job ? v.job.grade_label : v.grade.name}</td>
                <td class="table-last"><div onclick="manageEmployee('${v.name}', '${v.identifier || v.empSource}')">${translation.management.menu_employees_btn_manage}</div></td>
            </tr>
        `
    }
    return employeesData;
}

let balanceAlreadyRemoved = false
loadBalance = (balance) => {
    if (useBuildInBalance) {
        $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .title').html(`${translation.currency} ${number.format(balance)}`);
    } else {
        if (!balanceAlreadyRemoved && removeBalanceFromMenu) {
            var element = document.querySelector('.management-menu div[data-type="boss-management"] div[data-type="balance"]');
            if (element) element.remove();

            $('.management-menu div[data-type="boss-management"] .header-buttons').css({'grid-template-columns': 'auto'})
            $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"]').css({'width': '100%'})

            
            balanceAlreadyRemoved = true;
        }
        if (!removeBalanceFromMenu) {
            $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .title').html(`${translation.currency} ${number.format(balance)}`);

        }
    }
}
let translation = {};

let direction = "left"

var number = Intl.NumberFormat('en-US', {minimumFractionDigits: 0});

var isMenuOpened = false
var onReturnOpen = null
let menuPrevSelected = [];
let menuPrevSelectedIndex = '';

let currentMenu = null;
let selectedOption = null;

let selectedPercentage = null;
let selectedCount = null;

let discountCodesPercentages = [];
let discountCodesUsablesCount = [];
let enableDiscounts = false;
let useMissions = true;

let useBuildInBalance = true;
let removeBalanceFromMenu = false;

var partsLeft = 0;
var partsCount = 0;
var partsInstalled = 0;

var payFromSociety = false;
var sendBill = false;
var isClient = false;

var isEmployee = false;
var isManager = false;
var isBoss = false;
var cityhallGrades = false;

let useCityHall = false;
let useCityHallResumes = false;
let useCityHallTaxes = false;
let taxBusinessAllowMakeDelayedDeclarations = false;
let taxBusinessPercentagePerMonthForDelay = false;

var installationMarginTop = 0;

currentVehicleColor = "none";

String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

const generateColorPicker = function(r,g,b) {
    Pickr.create({
        el: ".color-picker",
        container: ".main-menu",
        showAlways: true,
        default: `rgb(${r},${g},${b})`,
        comparison: false,
        components: {
            preview: true,
            hue: true,
            interaction: {
                rgba: false,
                input: true,
                save: false,
            },
        },
        onChange(color) {
            if (currentVehicleColor != "none") {
                const colorRGB = color.toRGBA()
                $.post(`https://${GetParentResourceName()}/updateMod`, JSON.stringify({
                    mod: currentVehicleColor,
                    type: 'rgb',
                    r: Math.floor(colorRGB[0]),
                    g: Math.floor(colorRGB[1]),
                    b: Math.floor(colorRGB[2]),
                }));
            }
        },
    })
}

const changeStanceArrow = function(type, curDirection) {
    direction = curDirection;
    let inputValue = 0
    if (curDirection == 'left') {
        inputValue = Number(($(`#${type}-range`).val())) - 1
    } else {
        inputValue = Number($(`#${type}-range`).val()) + 1
    }
    
    let result = inputValue
    
    let min = $(`#${type}-range`).attr('min');
    let max = $(`#${type}-range`).attr('max');
    
    if (result < min) return;
    if (result > max) return;
    
    $(`#${type}-range`).val(result);
    $(`.stance-settings > .texts > p#${type}-value`).text(result);

    $.post(`https://${GetParentResourceName()}/updateMod`, JSON.stringify({
        mod: type,
        type: 'stance',
        value: Number(result)
    }));
}

const changeStanceRange = function(type) {
    let inputValue = parseInt($(`#${type}-range`).val())
    let result = inputValue
    $(`#${type}-range`).val(result);
    $(`.stance-settings > .texts > p#${type}-value`).text(result);
    $.post(`https://${GetParentResourceName()}/updateMod`, JSON.stringify({
        mod: type,
        type: 'stance',
        value: Number(result)
    }));
}

const changeModArrow = function(type, curDirection) {
    direction = curDirection;
    let inputValue = 0
    if (curDirection == 'left') {
        inputValue = Number(($(`#${type}-range`).val())) - 0.01
    } else {
        inputValue = Number($(`#${type}-range`).val()) + 0.01
    }
    
    let result = inputValue
    
    let min = $(`#${type}-range`).attr('min');
    let max = $(`#${type}-range`).attr('max');
    
    if (result < min) return;
    if (result > max) return;
    
    $(`#${type}-range`).val(result);
    $(`.stance-settin gs > .texts > p#${type}-value`).text(result);

    $.post(`https://${GetParentResourceName()}/updateMod`, JSON.stringify({
        mod: type,
        value: Number(result)
    }));
}

const changeModRange = function(type) {
    let inputValue = $(`#${type}-range`).val()
    let result = inputValue
    $(`#${type}-range`).val(result);
    $(`.stance-settings > .texts > p#${type}-value`).text(result);

    $.post(`https://${GetParentResourceName()}/updateMod`, JSON.stringify({
        mod: type,
        value: Number(result)
    }));
}

const copyToClipboard = (str) => {
    const el = document.createElement('textarea');
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
    $.post(`https://${GetParentResourceName()}/discountCode`, JSON.stringify({type: "copied"}));
};


window.addEventListener("load", function() {
    $.post(`https://${GetParentResourceName()}/loaded`)
})

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.action == "loaded") {
        enableDiscounts = item.enableDiscounts;
        useMissions = item.useMissions;
        discountCodesPercentages = item.discountCodesPercentages;
        discountCodesUsablesCount = item.discountCodesUsablesCount;
        useBuildInBalance = item.useBuildInBalance;
        removeBalanceFromMenu = item.removeBalanceFromMenu;

        useCityHall = item.useCityHall;
        useCityHallResumes = item.useCityHallResumes;
        useCityHallTaxes = item.useCityHallTaxes;
        useCityHallIncludedTaxes = item.useCityHallIncludedTaxes;

        taxBusinessAllowMakeDelayedDeclarations = item.taxBusinessAllowMakeDelayedDeclarations;
        taxBusinessPercentagePerMonthForDelay = item.taxBusinessPercentagePerMonthForDelay;

        if (!useMissions) {
            var element = document.querySelector('.management-menu > .menu > .side-bar > div[data-href="missions"]');
            if (element) element.remove();
        }        
        
        let lang = item.lang;
        $.ajax({
            url: '../config/translation.json',
            type: 'GET',
            dataType: 'json',
            success: function (code, statut) {
                if (!code[lang]) {
                    translation = code["EN"];
                    console.warn(`^3[WARNING] ^7Selected language ^1"${lang}"^7 not found, changed to ^2"EN"^7, configure your language in translation.json.`);
                } else {
                    translation = code[lang];
                }

                // Management Translation:
                $('.management-menu .side-bar div[data-href="main"] .title').text(translation.sidebar.main_title);
                $('.management-menu .side-bar div[data-href="main"] .description').text(translation.sidebar.main_description);
                $('.management-menu .side-bar div[data-href="missions"] .title').text(translation.sidebar.missions_title);
                $('.management-menu .side-bar div[data-href="missions"] .description').text(translation.sidebar.missions_description);
                $('.management-menu .side-bar div[data-href="employees"] .title').text(translation.sidebar.employees_title);
                $('.management-menu .side-bar div[data-href="employees"] .description').text(translation.sidebar.employees_description);
                $('.management-menu .side-bar div[data-href="discounts"] .title').text(translation.sidebar.discounts_title);
                $('.management-menu .side-bar div[data-href="discounts"] .description').text(translation.sidebar.discounts_description);
                $('.management-menu .side-bar div[data-href="boss-management"] .title').text(translation.sidebar.boss_management_title);
                $('.management-menu .side-bar div[data-href="boss-management"] .description').text(translation.sidebar.boss_management_description);
                
                // Main:
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .header').text(translation.main.menu_announcements_header);
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .title').text(translation.main.menu_announcements_title);
                $('.management-menu div[data-type="main"] div[data-type="total-tuned"] .header').text(translation.main.menu_total_tuned_header);
                $('.management-menu div[data-type="main"] div[data-type="total-earned"] .header').text(translation.main.menu_total_earned_header);
                $('.management-menu div[data-type="main"] div[data-type="best-sellers"] .header').text(translation.main.menu_best_sellers_header);

                // Missions:
                $('.management-menu div[data-type="missions"] .missions-list #missions-table thead tr th span#avatar').text(translation.missions.table_avatar);
                $('.management-menu div[data-type="missions"] .missions-list #missions-table thead tr th span#name').text(translation.missions.table_name);
                $('.management-menu div[data-type="missions"] .missions-list #missions-table thead tr th span#reward').text(translation.missions.table_reward);
                $('.management-menu div[data-type="missions"] .missions-list #missions-table thead tr th span#option').text(translation.missions.table_option);

                // Employees:
                $('.management-menu div[data-type="employees"] .header').text(translation.employees.menu_employees_header);
                $('.management-menu div[data-type="employees"] .title').text(translation.employees.menu_employees_title);
                $('.management-menu div[data-type="employees"] .btn[data-option="get_closest_players"] p').text(translation.employees.menu_employees_btn);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#employee').text(translation.employees.table_employee);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#grade').text(translation.employees.table_grade);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#option').text(translation.employees.table_option);

                // Discounts:
                $('.management-menu div[data-type="discounts"] .header').text(translation.discounts.menu_discounts_header);
                $('.management-menu div[data-type="discounts"] .title').text(translation.discounts.menu_discounts_title);
                $('.management-menu div[data-type="discounts"] .data > .percentages-name').text(translation.discounts.menu_select_percentage);
                $('.management-menu div[data-type="discounts"] .data > .counts-name').text(translation.discounts.menu_select_count);
                $('.management-menu div[data-type="discounts"] .btn[data-option="generate_code"] p').text(translation.discounts.menu_discounts_btn);
                $('.management-menu div[data-type="discounts"] .discounts-list #discounts-table thead tr th span#discount-code').text(translation.discounts.table_discountcode);
                $('.management-menu div[data-type="discounts"] .discounts-list #discounts-table thead tr th span#percentage').text(translation.discounts.table_percentage);
                $('.management-menu div[data-type="discounts"] .discounts-list #discounts-table thead tr th span#count').text(translation.discounts.table_count);
                $('.management-menu div[data-type="discounts"] .discounts-list #discounts-table thead tr th span#option').text(translation.discounts.table_option);

                // Management:
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .header').text(translation.management.menu_balance_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] div[data-option="withdraw"] p').text(translation.management.menu_balance_btn_withdraw);
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] div[data-option="deposit"] p').text(translation.management.menu_balance_btn_deposit);
                $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"] .header').text(translation.management.menu_employees_header);
                $('.management-menu div[data-type="boss-management"] div[data-option="employees"] p').text(translation.management.menu_employees_btn_manage);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .header').text(translation.management.menu_announcement_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .title').text(translation.management.menu_announcement_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .btn p').text(translation.management.menu_announcement_btn_send);

                if (useCityHall) {
                    let { CityHall_SideBars, CityHall_Menus } = window.mySharedFunction();
                    
                    $('.management-menu > .menu > .side-bar').append(`
                        ${useCityHallResumes ? (CityHall_SideBars.resumes).format(translation.sidebar.resumes_title, translation.sidebar.resumes_description) : ''}
                        ${useCityHallTaxes ? (CityHall_SideBars.taxes).format(translation.sidebar.taxes_title, translation.sidebar.taxes_description) : ''}
                    `)
    
                    $('.management-menu > .menu > .main').append(`
                        ${useCityHallResumes ? (CityHall_Menus.resumes).format(
                            translation.resumes.list_header,
                            translation.resumes.list_title,
    
                            translation.resumes.table_citizen,
                            translation.resumes.table_date,
                            translation.resumes.table_option,
    
                            translation.resumes.manage_header,
                            translation.resumes.manage_title,
    
                            translation.resumes.manage_description,
                            translation.resumes.manage_toggle_btn,
                        ) : ''}

                        ${useCityHallTaxes ? (CityHall_Menus.taxes).format(
                            translation.taxes.taxes_header,
                            translation.taxes.taxes_title
                        ) : ''}
                    `)
                }
            }
        });
    } else if (item.action == "openManagementMenu") {
        isEmployee = item.isEmployee;
        isManager = item.isManager;
        isBoss = item.isBoss;
        cityhallGrades = item.cityhallGrades;

        storeCfg = item.storeCfg;
        storeData = item.storeData;
        employees = item.employees;

        // Main Menu - loader:
        $('.management-menu .header .store-name').html(`${translation.menu_title}`)

        if (item.isManager || item.isBoss) {
            $('.management-menu .menu .side-bar div[data-href="employees"]').show();
            $('.management-menu .menu .side-bar div[data-href="boss-management"]').show();
            $('.management-menu .menu div[data-type="discounts"] > div > .box').show();
            $('.management-menu').addClass(item.isManager && 'isManager' || '').removeClass(item.isBoss && 'isManager' || '').removeClass('isEmployee');
        } else {
            $('.management-menu .menu .side-bar div[data-href="employees"]').hide();
            $('.management-menu .menu .side-bar div[data-href="boss-management"]').hide();
            $('.management-menu .menu div[data-type="discounts"] > div > .box').hide();
            $('.management-menu').addClass('isEmployee');
        }

        if (!enableDiscounts) $('.management-menu .menu .side-bar div[data-href="discounts"]').hide();

        // Announcements - loader:
        let announcementsData = loadAnnoucements(storeData.announcements);
        $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData);

        // Total Tuned - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-tuned"] .title').html(`${storeData.data.totalTuned}`);

        // Total Earned - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-earned"] .title').html(`${translation.currency} ${number.format(storeData.data.totalEarned)}`);

        // Missions - Loader:
        let missionsData = loadMissions(storeData.missions);
        $('.management-menu div[data-type="missions"] tbody').html(missionsData);

        // Employees - loader:
        let employeesData = loadEmployees(employees);
        $('.management-menu div[data-type="employees"] .box .data').html("");
        $('.management-menu div[data-type="employees"] tbody').html(employeesData);

        // Discount Codes - loader:
        let codesData = loadDiscountCodes(storeData.discountCodes);
        $('.management-menu div[data-type="discounts"] tbody').html(codesData);

        // Generate Discount Code - Loader:
        let {codesPercentages, codesCounts} = loadDiscountCodesGenerator();
        $('.management-menu div[data-type="discounts"] .data > .percentages').html(codesPercentages);
        $('.management-menu div[data-type="discounts"] .data > .counts').html(codesCounts);

        // Balance - loader:
        if (useBuildInBalance) {
            loadBalance(storeData.data.balance);
        }

        // Employees Count - loader:
        $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"] .title').html(`${item.employeesCount}`)

        // CityHall Resume's - loader:
        let isResumesAllowed = item.isResumesAllowed;
        if (isResumesAllowed != undefined) {
            if (item.isResumesAllowed) {
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').addClass('active')
            } else {
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').removeClass('active')
            }
            if (item.resumes) {
                let resumesList = ``
                let { CityHall_ResumesElement } = window.mySharedFunction();
                for (const [_, data] of Object.entries(item.resumes)) {
                    let element = CityHall_ResumesElement;
                    resumesList += element.format(data.sender_name, formatDate(data.date), data.sender)
                }
                $('div[data-type="resumes"] .side-boxes > div[data-type="list"] > .resumes-list > table > tbody').html(resumesList);
            }
            $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').html(isResumesAllowed ? translation.resumes.manage_description_active : translation.resumes.manage_description_not_active);
        }

        // CityHall Taxes - loader:
        let isTaxesAllowed = item.isTaxesAllowed;
        if (isTaxesAllowed != undefined) {
            if (item.taxes) {
                let { LoadTaxesMenu } = window.mySharedFunction();
                $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(item.taxes, 'vms_tuning'));
            }
        }

        if (cityhallGrades) {
            $('.management-menu .menu .side-bar div[data-href="resumes"]').hide();
            if (cityhallGrades['resumes']) {
                $('.management-menu .menu .side-bar div[data-href="resumes"]').show();
            }

            $('.management-menu .menu .side-bar div[data-href="taxes"]').hide();
            if (cityhallGrades['taxes']) {
                $('.management-menu .menu .side-bar div[data-href="taxes"]').show();
            }
        }

        currentMenu = 'management';
        updateManagement('main', `.management-menu .side-bar div[data-href="main"]`);
        $('.management-menu').fadeIn(120);
        $('body').fadeIn(150);

        let announcementsChat = document.getElementById("announcements-chat");
        announcementsChat.scrollTop = announcementsChat.scrollHeight;
    } else if (item.action == "closeManagementMenu") {
        $('.management-menu').fadeOut(120);
        
        $('.management-menu > .menu > .main > div').fadeOut(120);
        
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        
        $('input[data-input="withdraw"]').val('').hide();
        $('input[data-input="deposit"]').val('').hide();

        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal').removeClass('isVisible');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
    } else if (item.action == "updateManagementMenu") {
        if (!currentMenu) return;
        if (item.storeData) storeData = item.storeData;

        let announcementsData = loadAnnoucements(storeData.announcements);
        $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData);
        let announcementsChat = document.getElementById("announcements-chat");
        announcementsChat.scrollTop = announcementsChat.scrollHeight;
        
        // Total Tuned - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-tuned"] .title').html(`${storeData.data.totalTuned}`);

        // Total Earned - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-earned"] .title').html(`${translation.currency} ${number.format(storeData.data.totalEarned)}`);

        // Balance - loader:
        if (useBuildInBalance) {
            loadBalance(storeData.data.balance);
        }
        if (item.societyBalance) {
            loadBalance(Number(item.societyBalance));
        };

        if (item.employees) {
            employees = item.employees
            let employeesData = loadEmployees(employees);
            $('.management-menu div[data-type="employees"] tbody').html(employeesData)
        }

        let codesData = loadDiscountCodes(storeData.discountCodes);
        $('.management-menu div[data-type="discounts"] tbody').html(codesData);

        let missionsData = loadMissions(storeData.missions);
        $('.management-menu div[data-type="missions"] tbody').html(missionsData);

        if (item.taxes != undefined) {
            let { LoadTaxesMenu } = window.mySharedFunction();
            $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(item.taxes, 'vms_tuning'));
        }

        if (item.isResumesAllowed != undefined) {
            if (item.isResumesAllowed) {
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').addClass('active')
            } else {
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').removeClass('active')
            }
            $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').html(item.isResumesAllowed ? translation.resumes.manage_description_active : translation.resumes.manage_description_not_active);
        }

        if (currentMenu == "main") {
            
        } else if (currentMenu == "boss-management") {
            
        } else if (currentMenu == "employees" && item.players) {
            let players = item.players
            let hireData = ''
            $('.management-menu .main div[data-type="employees"] .box-right .data').html(`<div class="hire-list">${translation.employees.menu_employees_no_players}</div>`);
            for (const [k, v] of Object.entries(players)) {
                hireData += `
                    <div class="hire-player" data-playerid="${v}">
                        <div>${(translation.employees.citizen).format(v)}</div>
                        <div class="hire_btn" onclick="hireEmployee(${v})">${translation.employees.menu_option_hire_btn}</div>
                    </div>
                `;
            };
            $('.management-menu .main div[data-type="employees"] .box-right .data .hire-list').html(hireData);
        }
        

    } else if (item.action == "open") {
        if (!isMenuOpened) {
            currentMenu = 'tuning';
            $('body').fadeIn(150);
            $('.tuning-menu').fadeIn(150);
            if (!item.useDiscountCodes) {
                $(".header-discount-btn").remove();
            }
            payFromSociety = item.payFromSociety
            sendBill = item.sendBill
            isClient = item.isClient
            isMenuOpened = true;
            $('.tuning-menu .footer').html(`
                <div class="footer-button" onclick="footer('list')">
                    <div class="footer-name">${translation.tuningmenu.footer_selected_parts}</div>
                </div>
            `);
        }
    } else if (item.action == "close") {
        $.post(`https://${GetParentResourceName()}/close`);
        currentMenu = null;
        $('body').fadeOut(150);
        $('.tuning-menu').fadeOut(150);
        $('.header-back-btn').fadeOut(150);
        isMenuOpened = false;
    } else if (item.action == "update") {
        $('.color-picker').hide()
        $('.tuning-options').empty()
        $(".header-discount-btn").hide(100);
        if (item.menuOptions) {
            // item.menuOptions = Array.isArray(item.menuOptions) ? item.menuOptions.filter(val => val !== null) : [];
            
            menuPrevSelectedIndex = item.menuName;
            menuPrevSelected[menuPrevSelectedIndex] = 0;

            if (item.onReturnOpen) {
                onReturnOpen = item.onReturnOpen
                $('.header-back-btn').show(150)
            } else {
                onReturnOpen = null
                $('.header-back-btn').hide(150)
            }
            
            if (item.menuName == "mainmenu") {
                $('.tuning-menu .header-name').text(translation.tuningmenu.tuning_header)
            } else {
                $('.tuning-menu .header-name').text(item.menuLabel)
            }

            for (const [key, value] of Object.entries(item.menuOptions)) {
                if (value.show) {
                    $('.tuning-options').append(`
                        <div class="option">
                            ${value.icon && `
                                <div class="option-icon">
                                    <img src="icons/${value.icon}" draggable="false">
                                </div>` || ''
                            }
                            ${value.colorIcon && `
                                <div class="option-coloricon" style="background: ${value.colorIcon}"></div>` || ''
                            }
                            <div class="option-name">
                                <div class="title">${value.label}</div>
                                ${value.description && `<div class="description">${value.description}</div>` || ''}
                            </div>
                            ${value.price && `<div class="price">${translation.currency}${!useCityHallIncludedTaxes && value.priceWithTax != undefined && number.format(value.priceWithTax) || number.format(value.price)}</div>` || ''}
                            <div class="to-select ${value.isCurrent && 'selected' || ''}"
                                ${key && `data-id="${key}"` || ``}
                                ${value.action != undefined && `data-action="${value.action}"` || ``} 
                                ${value.modType != undefined && `data-modtype="${value.modType}"` || ``} 
                                ${value.type && `data-type="${value.type}"` || ``} 
                                ${value.price != undefined && `data-price="${value.price}"` || ``} 
                                ${value.priceWithTax != undefined && `data-price-with-tax="${value.priceWithTax}"` || ``} 
                                ${value.taxAmount != undefined && `data-tax-amount="${value.taxAmount}"` || ``} 
                                ${value.selectOpen && `data-selectopen="${value.selectOpen}"` || ``}
                                ${value.price != undefined && !value.selectOpen && `data-selectmod='${JSON.stringify({
                                    modLabel: item.menuLabel,
                                    modType: value.modType,
                                    modId: value.modId != undefined && value.modId,
                                    extraId: value.extraId != undefined && value.extraId,
                                    label: value.label,
                                    price: value.price,
                                    priceWithTax: value.priceWithTax,
                                    taxAmount: value.taxAmount,
                                })}'` || ''}
                            >${value.isCurrent && translation.tuningmenu.selected_part || translation.tuningmenu.select_part}</div>
                        </div>
                    `)
                }
            }
        }
    } else if (item.action == "openListOptions") {
        $('.tuning-menu .header-name').text(translation.tuningmenu.selected_parts_header)
        $('.tuning-options').html(`<div class="selected-options"></div>`);
        for (const [key, value] of Object.entries(item.optionsList)) {
            if (value) {
                $('.selected-options').append(`
                    <div class="listed-item">
                        <div class="name">${value.modLabel && `${value.modLabel} - ` || ''}${value.label}</div>
                        ${item.discount &&
                            `<div class="price">${translation.currency}${number.format((!useCityHallIncludedTaxes && value.priceWithTax != undefined && value.priceWithTax || value.price)*((100-item.discount)/100))}</div><div class="price discounted">${translation.currency}${!useCityHallIncludedTaxes && value.priceWithTax != undefined && number.format(value.priceWithTax) || number.format(value.price)}</div>` ||
                            `<div class="price">${translation.currency}${!useCityHallIncludedTaxes && value.priceWithTax != undefined && number.format(value.priceWithTax) || number.format(value.price)}</div>`}
                        <div class="remove" data-modtype="${value.modType}" ${value.extraId && `data-extraid="${value.extraId}"` || ''}><i class="fa-solid fa-xmark"></i></div>
                    </div>
                `)
            }
        }
        $(".header-discount-btn").fadeIn(100);
        $('.tuning-menu .footer').html(`
            <div class="footer-back-button" onclick="footer('back')">
                <div class="footer-name"><i class="fa-solid fa-chevron-left"></i></div>
            </div>
            <div class="footer-pay-button" onclick="footer('pay_options')">
                <div class="footer-name">${translation.tuningmenu.total_price} ${translation.currency}${item.discount && number.format(item.totalPrice*((100-item.discount)/100)) || number.format(item.totalPrice)}</div>
            </div>
        `)
    } else if (item.action == "updateListOptions") {
        $('.tuning-menu .footer .footer-pay-button').html(`
            <div class="footer-name">${translation.tuningmenu.total_price} ${translation.currency}${number.format(item.totalPrice)}</div>
        `)
    } else if (item.action == "openInstallation") {
        installationMarginTop = 0
        partsInstalled = 0
        partsCount = item.partsLeft
        partsLeft = item.partsLeft
        $('.installations-menu .header-name > span').text(translation.tuningmenu.list_header)
        $('.installations-menu .footer .parts-left').html(`${translation.tuningmenu.list_parts_left} ${partsLeft}`)
        $('.installations-menu .footer .parts-progress > span').html(`0%`)
        $('body').fadeIn(150);
        $('.installations-menu').fadeIn(150);
    } else if (item.action == "closeInstallation") {
        $('body').fadeOut(150);
        $('.installations-menu').fadeOut(150);
        $('.installations-menu > .options').empty(150);
    } else if (item.action == "updateInstallation") {
        if (item.status == 'installed') {
            partsLeft--
            partsInstalled++
            $(`.installations-menu > .options > div[data-modtype="${item.modType}"] > .label`).addClass('label-installed');
            $(`.installations-menu > .options > div[data-modtype="${item.modType}"] > .icon`).html('<i class="fa-regular fa-square-check"></i>').addClass('icon-installed');
            $('.installations-menu .footer .parts-left').html(`${translation.tuningmenu.list_parts_left} ${partsLeft}`);
            $('.installations-menu .footer .parts-progress > span').html(`${Number((100 * partsInstalled) / partsCount).toFixed(0)}%`)
            $('.installations-menu .footer .parts-progress > div').css(`width`, `${Number((100 * partsInstalled) / partsCount).toFixed(0)}%`)
            if (partsInstalled >= 7) {
                var elementOptions = document.getElementsByClassName('options');
                if (elementOptions.length > 0) {
                    var firstDiv = elementOptions[0].getElementsByTagName('div')[0];
                    if (firstDiv) {
                        installationMarginTop = installationMarginTop + 1.5
                        firstDiv.style.marginTop = `-${installationMarginTop}em`;
                    }
                }
            }
        }
        if (item.status == 'current') {
            $(`.installations-menu > .options > div[data-modtype="${item.modType}"] > .label`).addClass('label-current');
            $(`.installations-menu > .options > div[data-modtype="${item.modType}"] > .icon`).addClass('icon-current');
        }
        if (item.status == 'add') {
            $('.installations-menu > .options').append(`
                <div data-modtype="${item.modType}">
                    <div class="label">${item.modLabel && `${item.modLabel} - ` || ''}${item.label}</div>
                    <div class="icon">
                        <i class="fa-regular fa-square"></i>
                    </div>
                </div>
            `);
        }
    } else if (item.action == "updateDiscountCode") {
        if (item.isValid) {
            $("#discount-code-status .approved").text(`${translation.tuningmenu.discount_code_approved} ${item.percentage}%`)
            $("#discount-code-status .declined").text('')
        } else {
            $("#discount-code-status .approved").text('')
            $("#discount-code-status .declined").text(`${translation.tuningmenu.discount_code_declined}`)
        }
    } else if (item.action == "openReceipt") {
        currentMenu = 'receipt';
        $('.receipt > .receipt-texts > .header-label').text(translation.receipt.receipt_header)

        $('.receipt > .receipt-texts .item').text(translation.receipt.receipt_item)
        $('.receipt > .receipt-texts .amount').text(translation.receipt.receipt_amount)

        $('.receipt > .receipt-texts .total > div:first-child').text(translation.receipt.receipt_total)
        $('.receipt > .receipt-texts .total > div:nth-child(2)').html(`
            ${item.discount && `<span class="total-discounted">${item.totalPrice}${translation.receipt.currency}</span><br><span>${item.totalPrice*((100-item.discount)/100)}${translation.currency}<span>` || `<span>${item.totalPrice}${translation.currency}</span>`}
        `)
        $('.receipt > .receipt-texts .pay_cash').text(translation.receipt.receipt_pay_cash)
        $('.receipt > .receipt-texts .pay_bank').text(translation.receipt.receipt_pay_bank)
        $('.receipt > .receipt-texts .cancel').text(translation.receipt.receipt_cancel)
        
        $('body').fadeIn(150);
        $('.receipt').fadeIn(150);
    } else if (item.action == "closeReceipt") {
        currentMenu = null;
        $('body').fadeOut(150);
        $('.receipt').fadeOut(150);
        $('.receipt > .receipt-texts .list').empty()
    } else if (item.action == "updateReceipt") {
        $('.receipt > .receipt-texts .list').append(`
            <div class="product">
                <div>${item.modLabel && `${item.modLabel} - ` || ''}${item.label}</div>
                <div>
                    ${item.discount &&
                        `<span>${(!useCityHallIncludedTaxes && item.priceWithTax != undefined && item.priceWithTax || item.price)*((100-item.discount)/100)}${translation.currency}</span> <span class="receipt-discounted">${!useCityHallIncludedTaxes && value.priceWithTax != undefined && item.priceWithTax || item.price}${translation.currency}</span>` ||
                        `<span>${!useCityHallIncludedTaxes && item.priceWithTax != undefined && item.priceWithTax || item.price}${translation.currency}</span>`}
                </div>
            </div>
        `);
    } else if (item.action == "billFeedback") {
        if (item.status == 1) {
            $('.tuning-menu').css({'pointer-events': 'none', 'opacity': '.7'})
        } else {
            $('.tuning-menu').css({'pointer-events': 'all', 'opacity': '1.0'})
        }
    } else if (item.action == "openColorPicker") {
        generateColorPicker(
            item.isRGB && (item.r != undefined && String(item.r)) || 255,
            item.isRGB && (item.g != undefined && String(item.g)) || 255,
            item.isRGB && (item.b != undefined && String(item.b)) || 255,
        )
    } else if (item.action == "helpui") {
        if (item.type == "open") {
            $(".help-ui .text").empty();
            $(".help-ui .text").text(item.text);
            $(".help-ui").fadeIn(200);
        } else if (item.type == "close") {
            $(".help-ui").fadeOut(200);
        }
    }
});

$(".header-close-btn").click(function() {
    $.post(`https://${GetParentResourceName()}/close`);
    $('body').fadeOut(150);
    $('.tuning-menu').fadeOut(150);
    $('.header-back-btn').fadeOut(150);
    $('.discount-option').fadeOut(100);
    isMenuOpened = false;
})

$(document).on('click', '.header-discount-btn', function(e) {
    discountMenu('show')
});

$(document).on('click', '.header-back-btn', function(e) {
    returnSelected()
});

$(document).on('click', '.remove', function(e) {
    var modType = $(this).attr('data-modtype');
    var extraId = $(this).attr('data-extraid') || null;
    var listedItem = $(this).closest('.listed-item');
    listedItem.remove();
    $.post(`https://${GetParentResourceName()}/removeMod`, JSON.stringify({
        modType: modType,
        extraId: extraId,
    }));
});

$(document).on('click', '.receipt .buttons .pay_cash', function(e) {
    $.post(`https://${GetParentResourceName()}/bill`, JSON.stringify({
        action: 'pay',
        type: 'cash',
    }));
})

$(document).on('click', '.receipt .buttons .pay_bank', function(e) {
    $.post(`https://${GetParentResourceName()}/bill`, JSON.stringify({
        action: 'pay',
        type: 'bank',
    }));
})

$(document).on('click', '.receipt .buttons .cancel', function(e) {
    $.post(`https://${GetParentResourceName()}/bill`, JSON.stringify({
        action: 'cancel'
    }));
})
    
$(document).on('click', '.to-select', function(e) {
    if ($(this).hasClass('selected')) return;
    var action = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-action') || null;
    var newMenuName = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-selectopen') || null;
    var optionId = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-id') || null;
    var modType = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-modtype');
    var type = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-type') || null;
    var price = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-price') || null;
    var selectmod = $(this).eq(menuPrevSelected[menuPrevSelectedIndex]).attr('data-selectmod') || null;   
    if (selectmod) {
        if (type != "customlicenseplate" && !action) {
            selectMod(selectmod)
        }
        if (type == "colorpicker") {
            openColorPicker(modType)
            $.post(`https://${GetParentResourceName()}/enter`, JSON.stringify({
                type: 'colorpicker',
                optionId: optionId,
                previousMenuName: menuPrevSelectedIndex,
            }));
        } else if (action) {
            $.post(`https://${GetParentResourceName()}/enter`, JSON.stringify({
                action: action,
                selectmod: selectmod,
                menuName: menuPrevSelectedIndex
            }));
        } else if (type == "customlicenseplate") {
            $('.tuning-options').empty()
            $('.tuning-options').html(`
                <div class="plate-changer">
                    <div class="plate-input">
                        <input id="custom-plate-input" minlength="8" maxlength="8" type="text" onpaste="return false">
                        <div>${translation.tuningmenu.custom_plate_description1}<br>${translation.tuningmenu.custom_plate_description2}</div>
                    </div>
                    <div class="virtual-plate">
                        <p></p>
                        <img src="icons/customlicenseplate.png">
                    </div>
                    <div id="save-plate" class="to-select save-plate"
                        data-modtype="${modType}"
                        data-type="setcustomplate"
                    >${translation.tuningmenu.custom_plate_save}</div>
                    <div id="reset-plate" class="to-select reset-plate"
                        data-modtype="${modType}"
                        data-type="setcustomplate"
                        data-selectmod='${JSON.stringify({
                            modType: modType,
                            price: 0
                        })}'
                    >${translation.tuningmenu.custom_plate_reset}</div>
                </div>
            `)

            $('#custom-plate-input').on('input', function() {
                $(this).val($(this).val().replace(/[^a-z0-9 ]/gi, ''));
                $('.virtual-plate > p').text($("#custom-plate-input").val());

                document.getElementById('save-plate').setAttribute('data-selectmod', `${JSON.stringify({
                    modLabel: "Custom License Plate",
                    modType: modType,
                    modId: ($("#custom-plate-input").val()).toUpperCase(),
                    label:  ($("#custom-plate-input").val()).toUpperCase(),
                    price: price
                })}`)

            });
        } else if (type == "wheelsstance") {
            $.post(`https://${GetParentResourceName()}/getWheelsStance`, JSON.stringify({}), function(data) {
                if (data && data.allowedModification && data.values) {
                    $('.tuning-options').empty();
                    $('.tuning-options').html(`
                        <div class="stance-settings">
                            <div class="texts">
                                <p>${translation.tuningmenu.stance_offset_front}</p>
                                <p id="offset-front-value">${data['offset-front']}</p>
                            </div>
                            <div class="sliders">
                                <button onclick="changeStanceArrow('offset-front', 'left')" class="item-arrow-left"><i class="fa-solid fa-caret-left"></i></button>
                                <input type="range" min="${data.values['offset-front'].min}" max="${data.values['offset-front'].max}" value="${data['offset-front']}" id="offset-front-range" oninput="changeStanceRange('offset-front')">
                                <button onclick="changeStanceArrow('offset-front', 'right')" class="item-arrow-right"><i class="fa-solid fa-caret-right"></i></button>
                            </div>
                            <hr>
        
                            <div class="texts">
                                <p>${translation.tuningmenu.stance_offset_rear}</p>
                                <p id="offset-rear-value">${data['offset-rear']}</p>
                            </div>
                            <div class="sliders">
                                <button onclick="changeStanceArrow('offset-rear', 'left')" class="item-arrow-left"><i class="fa-solid fa-caret-left"></i></button>
                                <input type="range" min="${data.values['offset-rear'].min}" max="${data.values['offset-rear'].max}" value="${data['offset-rear']}" id="offset-rear-range" oninput="changeStanceRange('offset-rear')">
                                <button onclick="changeStanceArrow('offset-rear', 'right')" class="item-arrow-right"><i class="fa-solid fa-caret-right"></i></button>
                            </div>
                            <hr>
        
                            <div class="texts">
                                <p>${translation.tuningmenu.stance_rotation_front}</p>
                                <p id="rotation-front-value">${data['rotation-front']}</p>
                            </div>
                            <div class="sliders">
                                <button onclick="changeStanceArrow('rotation-front', 'left')" class="item-arrow-left"><i class="fa-solid fa-caret-left"></i></button>
                                <input type="range" min="${data.values['rotation-front'].min}" max="${data.values['rotation-front'].max}" value="${data['rotation-front']}" id="rotation-front-range" oninput="changeStanceRange('rotation-front')">
                                <button onclick="changeStanceArrow('rotation-front', 'right')" class="item-arrow-right"><i class="fa-solid fa-caret-right"></i></button>
                            </div>
                            <hr>
        
                            <div class="texts">
                                <p>${translation.tuningmenu.stance_rotation_rear}</p>
                                <p id="rotation-rear-value">${data['rotation-rear']}</p>
                            </div>
                            <div class="sliders">
                                <button onclick="changeStanceArrow('rotation-rear', 'left')" class="item-arrow-left"><i class="fa-solid fa-caret-left"></i></button>
                                <input type="range" min="${data.values['rotation-rear'].min}" max="${data.values['rotation-rear'].max}" value="${data['rotation-rear']}" id="rotation-rear-range" oninput="changeStanceRange('rotation-rear')">
                                <button onclick="changeStanceArrow('rotation-rear', 'right')" class="item-arrow-right"><i class="fa-solid fa-caret-right"></i></button>
                            </div>
                            <hr>
        
                        </div>
                    `)
                }
            });
        } else if (type == "suspensionheight" || type == "wheelsize" || type == "wheelwidth") {
            let modName = 
                type == 'suspensionheight' && 'suspensionHeight' ||
                type == 'wheelsize' && 'wheelSize' ||
                type == 'wheelwidth' && 'wheelWidth';

            let translationName = 
                type == 'suspensionheight' && translation.tuningmenu.suspension_height ||
                type == 'wheelsize' && translation.tuningmenu.wheel_size ||
                type == 'wheelwidth' && translation.tuningmenu.wheel_width;
            
            $.post(`https://${GetParentResourceName()}/getValue`, JSON.stringify({
                modType: modName
            }), function(data) {
                if (data && data.allowedModification && data.value != undefined) {
                    $('.tuning-options').empty();
                    $('.tuning-options').html(`
                        <div class="stance-settings">
                            <div class="texts">
                                <p>${translationName}</p>
                                <p id="${modName}-value">${data.value}</p>
                            </div>
                            <div class="sliders">
                                <button onclick="changeModArrow('${modName}', 'left')" class="item-arrow-left"><i class="fa-solid fa-caret-left"></i></button>
                                <input type="range" step="0.01" min="${data.min}" max="${data.max}" value="${data.value}" id="${modName}-range" oninput="changeModRange('${modName}')">
                                <button onclick="changeModArrow('${modName}', 'right')" class="item-arrow-right"><i class="fa-solid fa-caret-right"></i></button>
                            </div>
                            <hr>
        
                        </div>
                    `)
                }
            });
        } else {
            if (type != "setcustomplate") {
                $('.to-select').not(this).removeClass('selected');
                $('.to-select').not(this).text(translation.tuningmenu.select_part)
                $(this).addClass('selected');
                $(this).text(translation.tuningmenu.selected_part)
            }
        }
    } else {
        $.post(`https://${GetParentResourceName()}/enter`, JSON.stringify({
            menuName: newMenuName,
            optionId: optionId,
            modType: modType,
            type: type,
            previousMenuName: menuPrevSelectedIndex
        }));
    }
})

selectMod = function(data) {
    $.post(`https://${GetParentResourceName()}/selectMod`, data);
}

footer = function(action, moneyType) {
    if (action == 'back') {
        onReturnOpen = 'mainmenu';
        returnSelected();
    }
    if (action == 'pay_options') {
        $('.tuning-menu .footer').html(`
            <div class="footer-back-button" onclick="footer('back')">
                <div class="footer-name"><i class="fa-solid fa-chevron-left"></i></div>
            </div>
            <div class="footer-button" onclick="footer('pay', 'cash')">
                <div class="footer-name"><i class="fa-solid fa-money-bill-1-wave"></i> ${payFromSociety && translation.tuningmenu.footer_society || translation.tuningmenu.footer_cash}</div>
            </div>
            ${!payFromSociety && `
            <div class="footer-button" onclick="footer('pay', 'bank')">
                <div class="footer-name"><i class="fa-solid fa-building-columns"></i> ${translation.tuningmenu.footer_bank}</div>
            </div>
            ` || ''}
            ${sendBill && !isClient && `
            <div class="footer-button" onclick="footer('pay', 'bill')">
                <div class="footer-name"><i class="fa-solid fa-receipt"></i> ${translation.tuningmenu.footer_bill}</div>
            </div>
            ` || ''}
        `)
    }
    if (action == 'pay') {
        $.post(`https://${GetParentResourceName()}/pay`, JSON.stringify({moneyType: moneyType}));
    }
    if (action == 'list') {
        $.post(`https://${GetParentResourceName()}/openListOptions`, JSON.stringify({}));
    }
    $('.discount-option').fadeOut(100);
}

openColorPicker = function(colorType) {
    currentVehicleColor = colorType
    $('.tuning-options').empty()
    $('.tuning-options').append(`<div class="color-picker"></div>`)
    $.post(`https://${GetParentResourceName()}/openColorPicker`, JSON.stringify({
        colorType: colorType
    }));
}

returnSelected = function() {
    if (onReturnOpen) {
        $.post(`https://${GetParentResourceName()}/enter`, JSON.stringify({
            menuName: onReturnOpen
        }));
        $('.tuning-menu .footer').html(`
            <div class="footer-button" onclick="footer('list')">
                <div class="footer-name">${translation.tuningmenu.footer_selected_parts}</div>
            </div>
        `)
    } else {
        $.post(`https://${GetParentResourceName()}/close`);
        $('body').fadeOut(150);
        $('.header-back-btn').fadeOut(150)
        isMenuOpened = false;
    }
    $('.discount-option').fadeOut(100);
}

discountMenu = function(status) {
    if (status == 'show') {
        $('.discount-option').fadeIn(100);
        $('.discount-option').html(`
            <div class="discount-input">
                <input id="discount-code-input" minlength="1" maxlength="25" type="text">
                <div class="input-code">${translation.tuningmenu.discount_code_description}</div>
                <div id="discount-code-status">
                    <span class="approved"></span>
                    <span class="declined"></span>
                </div>
            </div>
            <div id="check-discount-menu" class="check-discount-menu" onclick="discountMenu('check')">${translation.tuningmenu.discount_code_check}</div>
            <div id="remove-discount" class="remove-discount" onclick="discountMenu('remove')">${translation.tuningmenu.discount_code_remove}</div>
        `);
        $('.tuning-menu .footer').html(`
            <div class="footer-back-button" onclick="footer('list')">
                <div class="footer-name"><i class="fa-solid fa-chevron-left"></i></div>
            </div>
        `)
    } else if (status == 'remove') {
        $('.discount-option').fadeOut(100);
        $.post(`https://${GetParentResourceName()}/discountCode`, JSON.stringify({
            type: 'remove',
        }));
    } else if (status == 'check') {
        $.post(`https://${GetParentResourceName()}/discountCode`, JSON.stringify({
            type: 'check',
            code: $("#discount-code-input").val()
        }));
    }
}


// 
//  MANAGEMENT MENU
// 



$(document).on('click', '.management-menu .side-bar .button', function(e) {
    let newMenu = $(this).data('href')
    updateManagement(newMenu, this)
})

function updateManagementSub(newMenu, _this) {
    if (newMenu == currentMenu) return;
    
    if (_this != selectedOption) {
        if (selectedOption) {
            $(selectedOption).removeClass("selected");
        }
        selectedOption = _this
        $(selectedOption).addClass("selected");
    }

    $(`div[data-type="${currentMenu}"]`).hide();

    currentMenu = newMenu
    $(`div[data-type="${currentMenu}"]`).show();

}

function updateManagement(newMenu, _this) {
    if (newMenu == currentMenu) return;

    if (newMenu != "employees") {
        $('.management-menu .main div[data-type="employees"] .box-right .data').empty();
    }

    if (_this != selectedOption) {
        if (selectedOption) {
            $(selectedOption).removeClass("selected");
        }
        selectedOption = _this
        $(selectedOption).addClass("selected");
    }
    
    $(`div[data-type="${currentMenu}"]`).hide();
    currentMenu = newMenu
    $(`div[data-type="${currentMenu}"]`).show();

    if (selectedPercentage) {
        $(`.management-menu div[data-type="discounts"] .data > .percentages > div[data-percentage="${selectedPercentage}"]`).removeClass("selected");
    }
    if (selectedCount) {
        $(`.management-menu div[data-type="discounts"] .data > .counts > div[data-count="${selectedCount}"]`).removeClass("selected");
    }
    selectedPercentage = null
    selectedCount = null
}

$(".close").click(function() {
    $.post(`https://${GetParentResourceName()}/closeManagementMenu`, JSON.stringify({menu: currentMenu}));
    isMenuOpened = false;
})

function hireEmployee(playerId) {
    if (playerId) {
        $.post(`https://${GetParentResourceName()}/hireEmployee`, JSON.stringify({playerId: playerId}));
    }
}

function bonusEmployee(identifier) {
    let bonusMoney = $("#bonus-money").val();
    if (identifier && bonusMoney && bonusMoney >= 1) {
        $.post(`https://${GetParentResourceName()}/bonusEmployee`, JSON.stringify({identifier: identifier, bonusMoney: bonusMoney}));
        $("#bonus-money").val('');
    }
}

function changeGradeEmployee(identifier, grade) {
    if (identifier && grade) {
        $.post(`https://${GetParentResourceName()}/changeGradeEmployee`, JSON.stringify({identifier: identifier, grade: grade}));
    }
}

function fireEmployee(identifier) {
    if (identifier) {
        $.post(`https://${GetParentResourceName()}/fireEmployee`, JSON.stringify({identifier: identifier}));
        $('.management-menu .main div[data-type="employees"] .box-right .data').empty();
    }
}

function manageEmployee(name, identifier) {
    let jobsToSet = ``
    for (const [key, job] of Object.entries(storeCfg.jobGradesToSet)) {
        if (job) {
            jobsToSet += `
                <div>
                    <div class="changegrade" onclick='changeGradeEmployee("${identifier}", ${
                        JSON.stringify(job)
                    })'>${translation.employees.menu_option_setjob_btn + job.label}</div>
                </div>
            `
        }
    }
    
    $('.management-menu .main div[data-type="employees"] .box-right .data').html(`
        <div class="employee-manage">
            <div class="player">
                <div class="player-name">${name}</div>
                <div class="bonus-bar">
                    <input type="number" id="bonus-money">
                    <div class="bonus" onclick="bonusEmployee('${identifier}')">${translation.employees.menu_option_bonus_btn}</div>
                </div>
                ${jobsToSet}
                <div>
                    <div class="fire" onclick="fireEmployee('${identifier}')">${translation.employees.menu_option_fire_btn}</div>
                </div>
            </div>
        </div>
    `);
}

$(document).on('keydown', 'body', function(e) {
    if (e.which == 27) {
        if (currentMenu != 'receipt' && currentMenu != 'tuning') {
            $.post(`https://${GetParentResourceName()}/closeManagementMenu`);
            isMenuOpened = false;
            currentMenu = null
        }
    }
})

function selectPercentage(_this) {
    let newPercentage = $(_this).data('percentage')
    if (newPercentage != selectedPercentage) {
        if (selectedPercentage) {
            $(`.management-menu div[data-type="discounts"] .data > .percentages > div[data-percentage="${selectedPercentage}"]`).removeClass("selected");
        }
        selectedPercentage = newPercentage
        $(_this).addClass("selected");
    }
}

function selectCount(_this) {
    let newCount = $(_this).data('count')
    if (newCount != selectedCount) {
        if (selectedCount) {
            $(`.management-menu div[data-type="discounts"] .data > .counts > div[data-count="${selectedCount}"]`).removeClass("selected");
        }
        selectedCount = newCount
        $(_this).addClass("selected");
    }
}

$(".btn").click(function() {
    let option = $(this).data('option')
    if (option == 'send-announce') {
        let text = $('textarea[data-type="announcement"]').val();
        message = text.trim();
        if (message !== "") {
            $.post(`https://${GetParentResourceName()}/sendAnnouncement`, JSON.stringify({text: text}));
            $('textarea[data-type="announcement"]').val("")
        }
    } else if (option == "withdraw") {
        $('.box[data-type="balance"] .close-balance').addClass('isVisible');
        $('input[data-input="withdraw"]').show();
        $('.btn[data-option="deposit"]').hide();
        $('.btn[data-option="withdraw"]').hide();
    } else if (option == "deposit") {
        $('.box[data-type="balance"] .close-balance').addClass('isVisible');
        $('input[data-input="deposit"]').show();
        $('.btn[data-option="deposit"]').hide();
        $('.btn[data-option="withdraw"]').hide();
    } else if (option == "get_closest_players") {
        $.post(`https://${GetParentResourceName()}/getClosestPlayers`);
    } else if (option == "generate_code") {
        if (!selectedPercentage) return;
        if (!selectedCount) return;
        $.post(`https://${GetParentResourceName()}/discountCode`, JSON.stringify({type: "generate", percentage: selectedPercentage, count: selectedCount}));
        if (selectedPercentage) {
            $(`.management-menu div[data-type="discounts"] .data > .percentages > div[data-percentage="${selectedPercentage}"]`).removeClass("selected");
        }
        if (selectedCount) {
            $(`.management-menu div[data-type="discounts"] .data > .counts > div[data-count="${selectedCount}"]`).removeClass("selected");
        }
        selectedPercentage = null
        selectedCount = null
    } else if (option == "employees") {
        updateManagementSub(option, `div[data-href="employees"]`)
    }
})

function balanceButton() {
    if ($('input[data-input="withdraw"]').val() >= 1) {
        let money = $('input[data-input="withdraw"]').val()
        $.post(`https://${GetParentResourceName()}/withdraw`, JSON.stringify({money: money}));
        $('input[data-input="withdraw"]').val('').hide();
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    } else if ($('input[data-input="deposit"]').val() >= 1) {
        let money = $('input[data-input="deposit"]').val()
        $.post(`https://${GetParentResourceName()}/deposit`, JSON.stringify({money: money}));
        $('input[data-input="deposit"]').val('').hide();
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    } else {
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('input[data-input="withdraw"]').val('').hide();
        $('input[data-input="deposit"]').val('').hide();
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    }
}

function onInputBalance(type) {
    let value = $(`input[data-input="${type}"]`).val();
    if (type == 'withdraw') {
        if (value >= 1) {
            $('.box[data-type="balance"] .close-balance').addClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-close').addClass('fa-check');
            
        } else {
            $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');

        }
    } else if (type == 'deposit') {
        if (value >= 1) {
            $('.box[data-type="balance"] .close-balance').addClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-close').addClass('fa-check');
            
        } else {
            $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');

        }
    }
}

function collectMission(missionData) {
    $.post(`https://${GetParentResourceName()}/takeMission`, JSON.stringify(missionData));
}

// 
// 
// 

var holdingRightButton = false

var oldx = 0;
var oldy = 0;

document.addEventListener('mousedown', function(event) {
    if (currentMenu == 'tuning') {
        if (event.button == 2) {
            if ($('.tuning-menu').is(':hover')) return;
            oldx = event.clientX
            oldy = event.clientY
            holdingRightButton = true;
        }
    }
});

document.addEventListener('mouseup', function(event) {
    if (holdingRightButton && event.button == 2) {
        holdingRightButton = false;
    }
});

document.addEventListener('mousemove', function (event) {
    if (holdingRightButton) {
        var deltaX = event.clientX - oldx;
        var deltaY = event.clientY - oldy;
        if (deltaX !== 0 || deltaY !== 0) {
            var direction = '';
            var absDeltaX = Math.abs(deltaX);
            var absDeltaY = Math.abs(deltaY);

            if (absDeltaX > absDeltaY) {
                if (deltaX > 0) {
                    direction = 'right';
                } else {
                    direction = 'left';
                }
            } else {
                if (deltaY > 0) {
                    direction = 'bottom';
                } else {
                    direction = 'top';
                }
            }

            oldx = event.clientX;
            oldy = event.clientY;

            $.post(`https://${GetParentResourceName()}/update_camera`, JSON.stringify({
                deltaX: deltaX,
                deltaY: deltaY
            }));
        }
    }
});

document.addEventListener("wheel", (e) => {
    if ($('.tuning-menu').is(':hover')) return;
    var zoom = e.deltaY > 1 && 'minus' || 'plus'
    $.post(`https://${GetParentResourceName()}/update_camera_zoom`, JSON.stringify({type: zoom}));
})
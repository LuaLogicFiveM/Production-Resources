Locales = {
    en = {

        getYourCorner = 'Get Your Corner.',
        favAnimation = 'Fav Animation',
        randomAnimation = 'Random Animation',

        notifications = {
            titles = {
                warning = 'Warning!',
                information = 'Information!',
            },

            notify = {
                noOneClose = "No one is nearby.",
                notAllowed = "You don't have the required permissions to perform this action!",
                dopingUseCheck = "You can't use doping this frequently.",
                dopingJobCheck = "Your job and experience do not allow you to perform this action.",
                dopingTestTrue = "The fighter's blood tested positive for doping!",
                dopingTestFalse = "No traces of doping were found in the fighter's blood.",
                wrongVector3Input = "All coordinates must be in vector3 format!",
                wrongVector4Input = "Boxer coordinates must be in vector4 format!",
                setFavAnim = "You have successfully selected your favorite animation!",
                jobOfferAccept = "The player accepted the job offer!",
                jobOfferDecline = "The player declined the job offer!",
                plyDistanceNotClose = "The player is too far away!",
                plyIsNotOnline = "Player not found!",
                invalidPlayer = "Invalid player ID!",
                fillAllFields = "Make sure to fill in all the fields!",
                enterValidNumber = "Please enter a valid number!",
                youAreBlacklisted = "You are on this club's blacklist.",
                noOpenBets = "There are no matches open for betting at the club.",
                noPastBets = "You have no bet history to view.",
                matchStarting = "The match starts in 3 seconds!",
                matchStarted = "The round has started!",
                notAllowedToPunch = "You're too exhausted to throw punches. Switch to defense mode and take a break!",
                alreadyStartedAMatch = "You can't manage more than one match at the same time.",
                boxersIsNotInArea = "The fighters are not in the arena.",
                notEnoughCash = "You don't have enough cash on you.",
                notEnoughMoney = "You don't have enough money.",
                boxerWin = "%s has won the match!",
                boxerLost = "You lost the match!",
                alreadyBlacklisted = "The player is already blacklisted!",
                alreadyHaveOwner = "This club already has an owner!",
                boxerNotOnline = "The fighters are not online!",
                alreadyWorker = "This person is already working with you.",
                gymCooldown = "Take a break, don't overwork your muscles",
                gymAfterWorkout = "That was a great set",      
                gymBenchFail = "You couldn't lift the bar, your arms are shaking.",
                gymCardioFail = "You're out of breath, can't continue.",
                gymPullUpFail = "Your grip slipped, almost fell.",
                gymSitUpFail = "Your abs cramped, too painful to continue.",
                gymOneHandCurlFail = "Your wrist bent awkwardly, had to drop the dumbbell.",
                gymBarbellCurlFail = "You tried to curl the bar but couldn't lift it.",
                gymPushUpFail = "Your chest gave in, you dropped to the floor.",
            }            
        },

        randomAnimation = '[E] - Random Animation',
        favAnimation = '[F] - Favorite Animation',

        alertDialogHeaders = {
            warning = '**Warning!**',
        },

        alertDialogButtons = {
            cancel = 'CANCEL',
            understood = 'UNDERSTOOD',
            confirm = 'CONFIRM',
            decline = 'DECLINE',
            accept = 'ACCEPT',
            close = 'CLOSE',
            remove = 'REMOVE',
            delete = 'DELETE',
        },

        adminCreateClub = {

            createClubLabel = 'Create A Club',
            
            clubNameLabel = "Club Name",
            clubPriceLabel = "Price",
            clubSaleLabel = "Can Players Buy?",
            clubNameDesc = "The name of the club to be created",
            clubPriceDesc = "The purchase cost of the club",
            clubSaleDesc = "Can this club be bought by players?",

            manageCoordLabel = "Management Coordinate",
            buyCoordLabel = "Purchase Coordinate",
            betCoordLabel = "Betting Area Coordinate",
            manageCoordDesc = "vector3(x, y, z)",
            buyCoordDesc = "vector3(x, y, z)",
            betCoordDesc = "vector3(x, y, z)",

            firstBoxerLabel = "Boxer 1 Coordinate",
            secondBoxerLabel = "Boxer 2 Coordinate",
            firstBoxerDesc = 'vector4(x, y, z, w)',
            secondBoxerDesc = 'vector4(x, y, z, w)',

            areaCorners = 'Identify the corners of the arena - ',
            chooseCorner = '[E] Select Corner',
            chooseMoreCornerOrContinue = 'Press [Enter] to continue or [E] to add more corners.',
            
            minZLabel = 'MinZ',
            maxZLabel = 'MaxZ',
            minZDesc = 'Minimum Z height of the fighting area',
            maxZDesc = 'Maximum Z height of the fighting area',

        },

        clubList = {
            contextMenu = {
                edit = {
                    title = 'Edit the details',
                    desc = 'Click to see the details!',
                },
                balance = {
                    title = "%s's Balance",
                    desc = "Modify the club's balance as an admin.",
                },
                clearTransaction = {
                    title = 'Clear Past Transactions',
                    desc = 'Click to clear the past transactions!',
                },
                deleteClub = {
                    title = 'Delete "%s"',
                    desc = 'Permanently delete this club and all of its data.',
                }
            },

            -- Edit ( Club Details )
            clubListDesc = 'Click here for more information!',
            clubListEditUpdateWarn = 'After making updates, you need to restart the script for the changes to take full effect.\n\nAttempting to apply changes without a restart may cause unnecessary load on the server and may also lead to inconsistencies for players. To ensure the best experience for everyone, a restart is required. Thank you for your understanding!',

            -- Balance
            updateClubBalanceLabel = 'Update Club Balance',
            newBalanceLabel = 'Enter New Balance',
            newBalanceDesc = 'Set a new balance for the club.',
            updateBalanceAlertContent = 'You are about to change the club\'s current balance. This action cannot be undone. Make sure the value you entered is correct before proceeding.',
        
            -- Clear Transactions
            clearTransactionsAlertContent = 'Past transactions are automatically managed by the script. However, clearing them manually can help optimize the database and reduce unnecessary load.\n\nAre you sure you want to clear past transactions? This action is irreversible!',

            -- Delete Club
            deleteClubAlertContent = 'You are about to permanently delete the club **%s**. This action cannot be undone and all associated data will be lost.'
        },

        targets = {
            manageLabel = 'Manage Club',
            purchaseLabel = 'Purchase Club',
            playBetLabel = 'Play Bet',
        },

        playBet = {
            contextMenu = {
                openBets = {
                    title = "Available Bets",
                    desc = 'Click to view available bets!',
                },
                selectBetType = {
                    title = "%s vs %s",
                    desc = "Odds: %s (`%s`) - %s (`%s`)",
                }
            },

            selectBetTypeContextHeader = 'Select Bet Type',

            betInputHeader = 'Bet Amount',
            betInputLabel = 'Amount',
            betInputDesc = 'Enter your stake',
            betConfirmHeader = "**Bet Confirmation**",
            betConfirmContent = "You will win **$%d** if your prediction is correct.\n\nAre you sure you want to proceed?",

            whoWinFirstRound = {
                contextTitle = "Who wins the first round?",
                contextDesc = 'You can bet on who will win the first round.',   
                inputHeader = 'Select Fighter',
                inputLabel = 'Choose Fighter',
                inputDesc = "Odds for this bet: %.2f" ,
            },

            anyKnockout = {
                contextTitle = "Will there be a knockout?",
                contextDesc = 'Bet on whether the match ends with a knockout.',   
                inputHeader = "Knockout Bet",
                inputLabel = "Select Knockout Option",
            },

            whoWinMatch = {
                contextTitle = "Who will win the match?",
                contextDesc = 'Predict the winner of the match.',   
                inputHeader = "Select Winner",
                inputLabel = "Choose Winner",
            },
            
            pastBets = {
                title = "Past Bets",
                desc = 'Click to view your past bets!',
                contextHeader = "Past Bets",
                firstRoundWinner = "1st Round Winner: %s",
                chooseWinner = "Match Winner: %s",
                isKnockout = "Will there be a knockout? %s",
                unknownType = "Bet Type: Unknown",
                yes = "Yes",
                no = "No",
                matchTitle = "%s vs %s",
                potentialWinnings = "\nPotential Winnings: $%s",
                clickToDelete = "\n**Click to delete**",
                cancelContent = "You wagered **$%d**.\nIf you cancel your bet, you'll lose **%s%%**, and you'll be refunded **$%d**.\nDo you want to proceed?",
            },
        },
        hireEmployee = {
            inputDialog = {
                header = 'Hire new employee',
                label = 'Player ID',
                desc = 'The ID of the person to be hired',
            },
            alertDialog = {
                header = '**Job Offer!**',
                content = '%s club wants to hire you. Do you accept the offer?'
            }
        },

        planMatch = {
            inputDialog = {
                boxerLabel = 'Boxer ID',
                boxeDesc = 'Enter the boxer\'s ID',
                roundLabel = 'Rounds',
                roundDesc = 'How many rounds will the match have? (3-6)',
                winPoolLabel = 'Win Pool',
                winPoolDesc = 'Prize money for the winning boxer',
                dateLabel = 'Select Date',
                dateDesc = 'Choose a date for the fight',
                timeLabel = 'Select Time',
                timeDesc = 'Choose the match time',
            },

            alertDialog = {
                header = '**Fight Participation Confirmation!**',
                content = '%s club is inviting you to the fight.\n\n **Prize Pool:** $%d \n\nDo you confirm your participation?'
            }
        },

        blackList = {
            inputDialog = {
                header = 'Add new blacklisted',
                idLabel = 'Player ID',
                idDesc = 'The ID of the person to be blacklisted',
                reasonLabel = 'Reason',
                reasonDesc = 'The reason for being blacklisted',
            },

            alertDialog = {
                reason = {
                    header = 'Blacklist Reason',
                    content = '**Reason:** %s',
                },

                blacklist = {
                    header = 'Remove Blacklist',
                    content = '**Are you sure you want to remove this person from the blacklist?**',
                }
            }
        },

        editMatch = {

            editDetails = {
                title = "Edit match details!",
                description = 'Click to see the details!',

                inputDialog = {
                    inputHeader = 'Update Match Details',
                    dateLabel = 'Select Date',
                    dateDesc = 'Choose a date for the fight',
                    timeLabel = 'Select Time',
                    timeDesc = 'Choose the match time',
                    roundLabel = 'Rounds',
                    roundDesc = 'How many rounds will the match have? (3-6)',
                    winPoolLabel = 'Win Pool',
                    winPoolDesc = 'Prize money for the winning boxer',
                },

                alertDialog = {
                    header = '**Match Editing Restricted**',
                    content = 'You cannot edit this match while betting is open. To make changes, you must first close betting.',
                }
            },

            editOddDetails = {
                title = "Edit the odd details!",
                description = 'Click to see the details!',

                inputDialog = {
                    labels = {
                        header = 'Update Match Details',
                        boxer1 = ' to Win',
                        boxer2 = ' to Win',
                        firstRound = 'Winner of First Round',
                        knockoutYes = 'Knockout: Yes',
                        knockoutNo = 'Knockout: No',
                    },
                    descriptions = {
                        boxer1 = 'Payout odds if %s wins the match.',
                        boxer2 = 'Payout odds if %s wins the match.',
                        firstRound = 'Odds for who will win the first round.',
                        knockoutYes = 'Payout odds if the match ends with a knockout.',
                        knockoutNo = 'Payout odds if there is no knockout during the match.',
                    },
                },

                alertDialog = {
                    header = '**Match Editing Restricted**',
                    content = 'You cannot edit this match while betting is open. To make changes, you must first close betting.',
                }
            },

            openBets = {
                titleOpen = "Open Bets",
                titleClose = "Close Bets",
            
                descOpen = "Click to open for new bets.",
                descClose = "Click to close & refund bets.",
            
                headerOpen = "**Open Bets?**",
                headerClose = "**Close Bets?**",
            
                contentOpen = "Opening bets will allow players to place new bets. Are you sure you want to proceed?",
                contentClose = "Closing bets will remove all active bets and refund the money to the players. Are you sure you want to proceed?",
            
                cancel = "CANCEL",
                confirmOpen = "OPEN BETS",
                confirmClose = "CLOSE BETS"
            },

            deleteMatch = {
                title = 'Delete Match',
                description = 'Click to delete the club!',

                alertDialog = {
                    header = '**Delete Match?**',
                    content = 'Are you sure you want to delete this match? This action cannot be undone.',
                }
            }
        },

        editEmployee = {
            contextTitle = 'Employee',

            edit = {
                title = "Edit %s's authorities",
                description = 'Click to see the details!',

                inputDialog = {
                    header = "%s's Authorities",
                    canWithdrawMoney = "Can they withdraw money from the company balance?",
                    canDepositMoney = "Can they deposit money into the company balance?",
                    canHireWorker = "Can they hire a new worker?",
                    canEditPermissions = "Can they edit workers' permissions?",
                    canFireWorker = "Can they fire workers?",
                    canPlanMatch = "Can they plan a match?",
                    canEditMatch = "Can they edit a scheduled match?",
                    canDeleteMatch = "Can they delete a scheduled match?",
                    canAddBlacklist = "Can they add players to the blacklist?",
                    canRemoveBlacklist = "Can they remove players from the blacklist?",
                    canManageMatch = "Can they manage a match?",
                    canPlayBet = "Can they open/close bets?"
                }
            },

            fire = {
                title = 'Fire %s',
                description = 'Click to fire the employee!',

                inputDialog = {
                    content = 'Are you sure you want to fire this employee?\n\nThis action cannot be undone, and the employee will be permanently removed from the system.',
                }
            }
        },

        startMatch = {
            alertDialogDescription = 'Click to start the match!',
        },

        webhook = {
            addFunds = {
                header = 'Cash Deposit',
                content = "**ShopID:** `%s`\n **Transaction Type:** `%s`\n **Amount:** `%d`\n **Player ID:** `%d`",
            },
            withdrawFunds = {
                header = 'Cash Withdrawal',
                content = "**ShopID:** `%s`\n **Transaction Type:** `%s`\n **Amount:** `%d`\n **Player ID:** `%d`",
            },            
            hireEmployee = {
                header = 'New Employee Hired',
                content = "**ShopID:** `%s`\n **Hired By:** `%s(%d)`\n **Employee Name:** `%s(%d)`",
            },
            editEmployee = {
                header = 'Employee Permissions Updated',
                content = "**ShopID:** `%s`\n**Changed By:** `%s (%d)`\n**Target Employee:** `%s`\n",
            },
            fireEmployee = {
                header = 'Employee Fired',
                content = "**ShopID:** `%s`\n**Fired By:** `%s (%d)`\n**Target Employee:** `%s`\n",
            },
            planMatch = {
                header = 'New Match Planned',
                content = "**ShopID:** `%s`\n**Planned By:** `%s (%d)`\n**MatchID:** `%d`\n",
            },
            editMatchDetail = {
                header = 'Match Details Updated',
                content = "**ShopID:** `%s`\n**Updated By:** `%s (%d)`\n**MatchID:** `%d`\n",
            },
            editOddDetail = {
                header = 'Odds Updated',
                content = "**ShopID:** `%s`\n**Updated By:** `%s (%d)`\n**MatchID:** `%d`\n",
            },
            deleteMatch = {
                header = 'Match Deleted',
                content = "**ShopID:** `%s`\n**Deleted By:** `%s (%d)`\n**MatchID:** `%d`\n",
            },
            addBlacklist = {
                header = 'Player Blacklisted',
                content = "**ShopID:** `%s`\n**Blacklisted By:** `%s (%d)`\n**Target Player:** `%s`\n",
            },
            removeBlacklist = {
                header = 'Player Removed from Blacklist',
                content = "**ShopID:** `%s`\n**Removed Blacklist By:** `%s (%d)`\n**Target Player:** `%s`\n",
            },
            playBet = {
                header = 'Played Bet',
                content = "**ShopID:** `%s`\n**MatchID:** `%s`\n**Amount:** `%.2f`\n**Ratio:** `x%.2f`\n",
            },
            cancelBet = {
                header = 'Cancelled Bet',
                content = "**ShopID:** `%s`\n**MatchID:** `%s`\n**Refunded Amount:** `%d`",
            },            
        },
        
        UI = { --  Don't change the string names
            managementText = 'Management',

            dashboardText = 'Dashboard',
            workerManagement = 'Worker Management',
            scheduledMatchPlan = 'Match Planning & Scheduled Matches',
            blacklistPlayers = 'Blacklist',
            exitText = 'Exit',
            hire_people = 'Hire New Employee',

            greetingsText = 'Greetings',
            companyBalance = 'Company Balance',
            balanceAmountPlaceHolder = "Enter amount",
            addfunds = 'Add Funds',
            withdrawfunds = 'Withdraw Funds',
            transactionHistoryText = 'Transaction History',

            manageEmployees = 'Manage Employees',

            plan_new_match = 'Plan New Match',
        }
    },
}

--local getLocales = Locales[NMConfig['General']['currentLocaleLanguage']]

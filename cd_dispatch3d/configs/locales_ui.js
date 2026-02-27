window["LOCALES"] = {
  main: {
    title: "Codesign Dispatch",
    onboarding: {
      welcome: {
        title: "Welcome to Dispatch!",
        content: `<h3 class="fw-semibold lh-1 m-0">Let's learn the basics together!</h3>
      <h5 class="fw-light lh-1 m-0 mb-3 text-muted">
        It won't take long, we promise.
      </h5>
      <p>
        We notice it's Your first time running Codesign's Dispatch system.
      </p>
      <hr />
      <p>
        By pressing the <kbd> <Icon name="play" /> Start</kbd> button on the
        bottom right of this window we will run You through the basics of
        using Dispatch.<br />
        If you think <strong>guides are boring</strong>, you can skip this
        tutorial by pressing the
        <kbd><Icon name="skip-end" /> Skip</kbd> button.
      </p>
      <hr />
      <p>
        You can always come back to this guide using the <kbd
          ><Icon name="question" /> Help</kbd
        > button on the top right of the screen.
      </p>
      <p>Let's get started!</p>`
      },
      steps: {
        step_1: {
          title: "Controls bar",
          message: `This is the controls bar. <br/>It contains all the main buttons you need to manage your dispatch.`
        },
        step_2: {
          title: "Camera modes",
          message: `This button allows you to switch between 2D and 3D view modes. <br/><small class='fst-italic'>*In planner mode the view is locked to 2D.</small>`
        },
        step_3: {
          title: "Planner mode",
          message: `Toggling planner mode allows You to create, save and share Your action plans with other users.`
        },
        step_4: {
          title: "Heatmap mode",
          message: `Toggling the heatmap mode allows You to visualize the most impacted areas of the map.`
        },
        step_5: {
          title: "Labels display",
          message: `Toggling the labels will display names and callsigns above the units on the map.`,
        },
        step_6: {
          title: "Voice toggle",
          message: `Toggles your microphone on/off and allows you to communicate with other users via Radio.`
        },
        step_7: {
          title: "Settings",
          message: `Settings allow players to change their Status, Callsign and enable Dispatcher mode if they have proper permissions. <hr/>
      Quickview settings allow players to reposition the Quickview window, enable pop-up mode or hide it completely. <hr/>
      Dispatch graphical settings and sound settings can also be found here.`
        },
        step_8: {
          title: "Notifications panel",
          message: `This panel displays all active notifications.<br/> We have provided sample data to help explain the layout. These are not real notifications or units.`,
        },
        step_9: {
          title: "New notification",
          message: `Every dispatcher can create a new notification by pressing this button. Once pressed, a new window will open where You can fill in the notification data.`
        },
        step_10: {
          title: "Notification",
          message: `Every notification follows the same layout.<br/>
      Title, message, number of responding units and time passed since the notification arrived.<br/>
      Urgent notifications are distinguished with a blue - red background.
      <hr/>
      In order to assign units to the notification, You can <kbd>right click</kbd> on it and select the unit from the list.<br/>
      This action also opens a larger context menu with additional options.
      <hr/>
      By <kbd>clicking</kbd> the notification You can see the responding units. <br/>
      By <kbd>double-clicking</kbd> the notification You can move the map to the notification location.<br/>
      `
        },
        step_11: {
          title: "Units panel",
          message: `The units panel displays all active units on the server.`
        },
        step_12: {
          title: "New unit",
          message: `This button is invisible until You become a Dispatcher. <br/>Pressing the button will create a new unit group.<br/> 
      To add units to this group you can <kbd>drag and drop</kbd> the player from one group to another.<br/> 
      The units will automatically synchronize with all other players.`
        },
        step_13: {
          title: "Group",
          message: `Groups are collection of units. Their main purpose is to make assigning calls to players easier.<br/> 
      Each group has a name and a color.<br/> 
      Every group can be deleted or edited except the Unassigned group.`
        },
        step_14: {
          title: "Unit",
          message: `From left to right, each unit has a transport type, callsign, name, channel and availability (colored circle behind channel number.)<br/> 
      By default, all units belong to the Unassigned group.<br/> 
      As Dispatcher, You can assign them to a group by <kbd>dragging and dropping</kbd> them into a group.<hr/>
      <kbd>Double clicking</kbd> the unit will move your camera to the unit location.<br/>
      <kbd>Right clicking</kbd> the unit will open a context menu with additional options.<br/>`
        },
        step_15: {
          title: "The end! 🎉",
          message: `You have reached the end of the general guide!<br/>
    Feel free to explore the app (within the guidelines of Your server) and discover all the features.<br/>
    Further help will be provided as You use Dispatch. <hr/>
    As a reminder, You can always reset the onboarding by pressing the <kbd>Help</kbd> button in the top right section of the control menu.<br/>`
        },
        step_16: {
          title: "The map",
          message: `As you have probably noticed, the map is now in 3D.
          <br/>
          This means the controls are slightly different.
          </br>
          <kbd>Left Click</kbd> - Rotate the camera<br/>
          <kbd>Right Click</kbd> - Move the camera<br/>
          <kbd>Scroll</kbd> - Zoom in/out<br/>
          <hr/>
          As a side note, you can <kbd>double click</kbd> a notification or unit to move the camera towards their direction.<br/>`
        }
      }
    }
  },

  control_menu: {
    title: "Codesign Dispatch",
    mode_2d: "2D Mode",
    mode_3d: "3D Mode",
    planner: "Planner",
    heatmap: "Heatmap",
    voice_on: "Voice On",
    voice_off: "Voice Off",
    labels: "Labels",
    settings: "Settings",
  },

  quickview: {
    move_mode: "Move mode",
    move_mode_description: "Move the window by dragging from the header bar.",
    action_save_position: "Save position",
    no_notifications: "No notifications",
    no_notifications_description: "There are no notifications to display.",
    action_respond: "Respond",
    note_away: "away", // As in x meters away
    no_location: "No location",
    at_location: "At location"
  },

  planner: {
    onboarding: {
      welcome: {
        title: "The planner",
        content: `<h3 class="fw-semibold lh-1 m-0">Dispatch planner</h3>
				<h5 class="fw-light lh-1 m-0 mb-3 text-muted">
					Create, edit and share action plans with the planner tool
				</h5>
				<p>In the following guide we will introduce You to the basics of using the planner</p>
				<p>We can highly recommend going through this short guide in order to get to know how the tools and basic planner operations work!</p>
				<hr/>
				<p>Press the <kbd>Start</kbd> button to continue with the guide or press <kbd>Skip</kbd> if You are already familiar with the planner.</p>`
      },
      steps: {
        step_1: {
          title: "Planner controls",
          message: `The planner controls represent the main interface for creating and managing plans.<br/>`
        },
        step_2: {
          title: "Plan name",
          message: `This is Your plan name. You can change it by <kbd>clicking</kbd> on it and typing a new name, or entering a new name later, when saving the plan.`,
        },
        step_3: {
          title: "Planner menu",
          message: `This is the planner menu.<br/>
			It allows you to open, save, share and create new plans.`,
        },
        step_4: {
          title: "Planner tools",
          message: `These are the planner tools.<br/>
			They allow you to create and manage the layers of your plan.<hr/>
			To select a tool simply <kbd>click</kbd> on it, and a new layer will be created for you to use the tool.<br/>
			`
        },
        step_5: {
          title: "Zone tool",
          message: `The zone tool allows You to create a polygon zone on the map.<hr/>
			<span class="fw-semibold">Creating a zone</span><br/>
			To place zone points <kbd>click</kbd> on the desired location. Once 4 points are placed the zone will be created.<br/>
			You can also add more points by <kbd>double-clicking</kbd> on the zone edge where You want to add a point.<hr/>
			<span class="fw-semibold">Editing the zone</span><br/>
			Each zone point can be moved by <kbd>clicking</kbd> on it and <kbd>dragging</kbd> it to the desired location.<br/>
			<small class="text-muted">*Due to the nature of the 3D map, in certain cases zones with more than 4 points might have an unexpected shape.</small>`
        },
        step_6: {
          title: "Radius tool",
          message: `The radius tool allows You to create a circular zone on the map.<hr/>
			<span class="fw-semibold">Creating a radius zone</span><br/>
			By <kbd>clicking</kbd> on the desired location You are creating a center point of the zone.<br/>
			<kbd>Clicking</kbd> on another point will create a radius from the center point to the clicked point.<hr/>
			<span class="fw-semibold">Editing a radius zone</span><br/>
			Moving the center point will move the complete zone, and moving the edge point will change the radius of the zone.<br/>`
        },
        step_7: {
          title: "Line tool",
          message: `The line tool allows You to create a line on the map.<hr/>
			<span class="fw-semibold">Creating a line</span><br/>
			<kbd>Clicking</kbd> on the desired location will create a line start-point.<br/>
			Clicking on another point will create a line end-point.<hr/>
			<span class="fw-semibold">Editing a line</span><br/>
			To reposition the line move the line points by <kbd>clicking</kbd> and <kbd>dragging</kbd> to the desired location.
			`
        },
        step_8: {
          title: "Arrow tool",
          message: `The arrow tool works on the same principle as the line tool, except the end point has an arrow.`
        },
        step_9: {
          title: "Text tool",
          message: `The text tool allows You to create a text label on the map.<hr/>
			<span class="fw-semibold">Creating a text label</span><br/>
			To choose a location for the text label <kbd>click</kbd> on the desired location.<hr/>
			<span class="fw-semibold">Editing a text label</span><br/>
			To move the text label <kbd>click</kbd> on a new location and the text will be moved there.`
        },
        step_10: {
          title: "Layer settings",
          message:`Properties of the selected tool are displayed in the box below.<br/>
			Changing these properties will reflect on the map. You can adjust properties before or after you draw on the map.<br/>`
        },
        step_11: {
          title: "Close planner",
          message: `This button closes the planner.<br/> Closing the planner will not delete your plan, it will just hide the planner interface.<br/>`
        },
        step_12: {
          title: "Planner layers",
          message: `Your plan layers are displayed here.<br/>
			Each layer represents a different element of your plan, and you can select a layer by clicking on it on this list.<br/>`
        },
        step_13: {
          title: "Add new layer",
          message: `Clicking this button will create a new layer in your plan based on the selected tool.`
        },
        step_14: {
          title: "Planner layer",
          message: `Each entry in the list represents a layer of your plan.<br/>
			From left to right you can see the tool icon, the layer name, the layer visibility toggle, and the delete button.<br/>
			You can rename layers by clicking on the name and typing.`
        }
      }
    },
    open_window: {
      title: "Plan browser",
      local_plans: "Local Plans",
      server_plans: "Server Plans",
      shared_plans: "Shared Plans",
      loading_server_plans: "Loading server plans...",
      open_plan: "Open plan",
    },
    save_window: {
      title: "Save plan",
      plan_name: "Plan name",
      save_local: "Save to local",
      save_local_description: "*This option saves the plan to your local storage. It will only be visible to you, unless you share it with other users.",
      save_server: "Save to server",
      save_server_description: "*This option saves the plan to the server, and it will be visible to anyone who can access the Dispatch.",
      save_warning: "Saving will overwrite the old plan.",
      action_save: "Save plan",
    },
    share_window: {
      title: "Share plans",
      no_players: "No players available.",
      no_plans: "No plans available. Create a plan, save it locally and then try to share.",
      players_selected: "players selected", // x/x players selected,
      plans_selected: "plans selected", // x/x plans selected,
      select_players: "Select players",

    },

    saving: "Saving to local storage...",
    created: "Created", // x time ago 
    no_plans: "No plans found",
    storage_full: "Your local storage is full! Please delete some local plans before saving a shared plan.",
    label_tools: "Tools",
    tool_settings: {
      color: "Color",
      border: "Border",
      weight: "Weight",
      dashed: "Dashed",
      text: "Text",
      text_color: "Text color",
      size: "Size",
      rotation: "Rotation",
      font: "Font",
      background_color: "Background color",
      transparent: "Transparent background",
    },
    layers: "Layers",
    action_new_layer: "New layer",

  },

  heatmap: {
    title: "Heatmap",
    tools: "Tools",
    opacity: "Heatmap opacity"
  },

  settings: {
    title: "Dispatch settings",
    tabs: {
      general: "General",
      quickview: "Quickview",
      video: "Video",
      sounds: "Sounds",
    },
    general: {
      status: "Status",
      status_description: "Select your current status.",
      callsign: "Callsign",
      callsign_description: "This callsign will be visible to all of the dispatch users.",
      dispatcher: "Dispatcher mode",
      dispatcher_description: "Toggle dispatcher mode",
      dispatcher_state: "Dispatcher mode is currently", //enabled/disabled
      dispatcher_no_perms: "You do not have the correct permissions to be a dispatcher.",
      dispatcher_timeout: ["You cannot change dispatcher mode for", "seconds."]
    },
    video: {
      performance: "Performance metrics",
      performance_description: "Enable performance metrics.",
      performance_description_2: "Displays FPS / Time to draw / Memory usage in the bottom right of the screen. Click on the graph to change display.",
      antialiasing: "Anti-aliasing",
      antialiasing_description: "Smooths jagged edges. Disabling anti-aliasing improves performance.",
      shadows: "Shadows",
      shadows_tier: {
        off: "Off",
        low: "Low",
        medium: "Medium",
        high: "High",
      },
      shadows_description: "Quality of shadows. Disabling shadows improves performance.",
      water_reflections: "Water reflections",
      water_reflections_description: "Disabling water reflections greatly improves performance.",
      fog: "Fog",
      fog_distance: "Fog distance",
      fog_description: "Disabling fog has minimal effect on performance.",
    },
    quickview: {
      unit_system: "Unit system",
      unit_metric: "Metric",
      unit_imperial: "Imperial",
      unit_description: "Choose the unit system used for distance.",
      position: "Position",
      position_adjust: "Adjust position",
      position_adjust_description: "Adjust the position of the quickview window. (Small UI)",
      position_reset: "Reset position",
      position_reset_description: "Resets position to default.",
      visibility: "Visibility",
      visibility_hide: "Hide quickview",
      visibility_hide_description: "If checked the Quickview will remain hidden at all times.",
      visibility_popup: "Pop-up mode",
      visiblity_popup_description: "If checked the Quickview will stay hidden until a new notification is received",
      popup_timer: "Pop-up timer",
      popup_seconds: "seconds",
      popup_timer_description: "Amount of seconds after which the pop up quickview hides again.",
    },
    sounds: {
      ui: "User interface",
      volume: "Volume",
      ui_description: "Affects interface sounds such as mouse-over sounds and button clicks.",
      quickview: "Quickview sounds",
      quickview_description: "Affects only quickview sounds such as new notifications and panic sounds.",
      tts: "Text to speech",
      tts_description: "Allows to control the text to speech functionality. This will read out incoming notifications.",
      tts_voices: "Available voices",
      tts_voices_description: "These voices are provided by Your system.",
      tts_rate: "Speech rate",
      tts_rate_description: "Rate of speech. Higher values will make the speech faster.",
      tts_pitch: "Speech pitch",
      tts_pitch_description: "Pitch of the speech. Higher values will make the speech higher.",
      tts_volume: "Speech volume",
      tts_preview: "Preview",  
    }
  },

  units_panel: {
    label: "Units panel",
    unassigned: "Unassigned",
    context_menu: {
      unit: "Unit",
      follow_player: "Follow player",
      set_gps: "Set GPS Location",
      track_gps: "Track GPS Location",
      cancel_track_gps: "Cancel GPS Tracking",
      radio: "Radio",
      join_radio: "Join radio channel",
      leave_radio: "Leave radio channel",
      set_radio: "Set radio channel",
      set_radio_description: "Changing the unit channel will change the channel for this unit only.",
      set_group_radio: "Set group radio channel",
      set_group_radio_description: "Changing the group channel will change the channel for all players in the group.",
    },
    unit_settings: {
      label: "Group settings",
      name: "Group name",
      color: "Group color",
      action_reset: "Reset color",
    },
    note: {
      //                               |
      //                               |
      //                               |
      //                               v "backspace" is the icon name from the icon set found here https://icons.getbootstrap.com/
      cancel_track: ["Press", "backspace", "Backspace to cancel GPS tracking."],
    }
  },

  notifications_panel: {
    label: "Notification panel",
    units_responding: "units responding",
    input_search_term: "Input search term",
    context_menu: {
      units: "Units",
      action_assign_player: "Assign player to call",
      action_remove_player: "Remove player from call",
      action_assign_unit: "Assign specific unit to call",
      action_remove_unit: "Remove specific unit from call",
      action_assign_all: "Assign all units to call",
      responding: "Responding",
      respond: "Respond to notification",
      remove_response: "Remove notification response",
      notification: "Notification",
      remove: "Remove this notification",
      remove_all: "Remove all notifications",
      remove_all_message: `Are you sure you want to remove all notifications?`,
    },
    new_notification: {
      label: "Creating a new notification",
      title: "Notification title",
      title_error: "You need to enter a title of the notification.",
      message: "Notification message",
      message_error: "You need to enter a message of the notification.",
      location: "Location",
      update_location: "Update location",
      select_location: "Select a location on map",
      urgent: "Urgent notification",
      urgent_description: "*Urgent notifications will flash on the notification panel and quickview.",
      anonymous: "Anonymous notification",
      anonymous_description: "*Anonymous notifications will not display the sender's name.",
      dispatcher_warning: "A dispatcher is active. You will not be able to see this notification on the left-hand side panel.",
      get_location: {
        title: "Select a location",
        none_selected: "No location selected",
        select_description: "*You can select a location by double clicking a desired position on the map.",
        edit_selection_description: `*You can change your selection by double clicking a different position
					on the map.`,
        confirm_selection: "Confirm selection",
      }
    }
  },

  loadscreen: {
    title: "Loading map",
    status: "Loading asset", // x/y
  },

  general: {
    action_new: "New",
    action_open: "Open",
    action_save: "Save",
    action_share: "Share",
    action_close: "Close",
    action_create: "Create",
    action_confirm: "Confirm",
    action_start: "Start",
    action_skip: "Skip",
    action_previous: "Previous",
    action_next: "Next",
    action_back: "Back",
    action_help: "Help",
    action_finish: "Finish",
    action_hide: "Hide",
    action_show: "Show",
    label_steps: "steps",
    label_settings: "settings",
    enabled: "Enabled",
    disabled: "Disabled",
    seconds: "Seconds",
    preposition_for: "for",
    
    label_kilometers: " km",
    label_meters: " m",
    label_miles: " mi",
    label_feet: " ft",
  }
}
window['dayjs-locale'] = {
    weekdays: 'Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday'.split('_'),
    weekdaysShort: 'Sun_Mon_Tue_Wed_Thu_Fri_Sat'.split('_'),
    weekdaysMin: 'Su_Mo_Tu_We_Th_Fr_Sa'.split('_'),
    weekStart: 0, // In the US, Sunday is typically the first day of the week
    yearStart: 1, // ISO-like standard, optional, can remain 1
    months: 'January_February_March_April_May_June_July_August_September_October_November_December'.split('_'),
    monthsShort: 'Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec'.split('_'),
    ordinal: n => {
      const s = ["th", "st", "nd", "rd"];
      const v = n % 100;
      return n + (s[(v - 20) % 10] || s[v] || s[0]);
    },
    formats: {
      LTS: 'h:mm:ss A',
      LT: 'h:mm A',
      L: 'MM/DD/YYYY',
      LL: 'MMMM D, YYYY',
      LLL: 'MMMM D, YYYY h:mm A',
      LLLL: 'dddd, MMMM D, YYYY h:mm A',
      l: 'M/D/YYYY',
      ll: 'MMM D, YYYY',
      lll: 'MMM D, YYYY h:mm A',
      llll: 'ddd, MMM D, YYYY h:mm A'
    },
    relativeTime: {
      future: 'in %s',
      past: '%s ago',
      s: 'a few seconds',
      m: 'a minute',
      mm: '%d minutes',
      h: 'an hour',
      hh: '%d hours',
      d: 'a day',
      dd: '%d days',
      M: 'a month',
      MM: '%d months',
      y: 'a year',
      yy: '%d years'
    },
    meridiem: (hour, minute, isLowercase) => {
      return hour >= 12 ? 'PM' : 'AM';
    }
  };
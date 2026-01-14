window.appConfig = {

    logo: {
        link: 'https://i.ibb.co/YLLNHJP/lorp-logo-main.png', // Use link or relative directory if local
        scale: 1, // For making the logo bigger and smaller
    },


    background: {
        type: 'video', // Use 'image' for image slider or use 'video' for video background
        video: 'https://r2.fivemanage.com/rLJIb9pTvemcICUlWQfgd/lorp.mp4', // YouTube link or direct video link ending with compatible formats (.mp4 etc) or relative directory if local (assets/video/video.mp4)
        mute: true, // Wether to mute the background video or not, this might not work due to browser policies (video might not autoplay if not muted)
        images: [ // You can add more images or remove them
            'https://www.rockstargames.com/VI/_next/image?url=%2FVI%2F_next%2Fstatic%2Fmedia%2FJason_and_Lucia_Motel_landscape.565a08c8.jpg&w=1920&q=75', // Use link or relative directory if local
            'https://www.rockstargames.com/VI/_next/image?url=%2FVI%2F_next%2Fstatic%2Fmedia%2FDreQuan_Priest_landscape.9070b529.jpg&w=1920&q=75',
            'https://www.rockstargames.com/VI/_next/image?url=%2FVI%2F_next%2Fstatic%2Fmedia%2FBoobie_Ike_landscape.67ebb1f6.jpg&w=1920&q=75',
            'https://www.rockstargames.com/VI/_next/image?url=%2FVI%2F_next%2Fstatic%2Fmedia%2FBrian_Heder_landscape.e88fb1ab.jpg&w=1920&q=75',
            'https://www.rockstargames.com/VI/_next/image?url=%2FVI%2F_next%2Fstatic%2Fmedia%2FReal_Dimez_landscape.f16de7d4.jpg&w=1920&q=75'
        ],
    },


    songs: { // Use songs: false, if you don't need the music player and music at all - You can add more or remove songs. Recommended to use atleast 2 songs.
        1: {
            name: 'Hood Politics', // Name of the song
            artist: 'Babyface Ray & Big Sean', // Artist of the song
            image: 'https://i.ibb.co/ZRm0zzXS/babyface-ray.jpg', // Image art of the song. Use square images only.
            audioLink: 'assets/music/babyface_ray.mp3' // You can use direct URL to the song ending in compatible formats (.mp3 etc) or relative directory if local
        },
        2: {
            name: 'Warm Breeze',
            artist: 'Jamey Johnson',
            image: 'https://i.ibb.co/xqG7tg1P/jamie-johnson.jpg',
            audioLink: 'assets/music/jamie_johnson.mp3'
        },
        3: {
            name: 'All on Me',
            artist: 'Lil Baby & G Herbo',
            image: 'https://i.ibb.co/d0p7BDFQ/lil-baby.jpg',
            audioLink: 'assets/music/lil_baby.mp3'
        },
        4: {
            name: 'Missed Call',
            artist: 'Treaty Oak Revival',
            image: 'https://i.ibb.co/yJ0y7j8/treaty-oak.jpg',
            audioLink: 'assets/music/treaty_oak.mp3'
        },
        5: {
            name: 'Signed Napkin',
            artist: 'Veeze',
            image: 'https://i.ibb.co/zWdN6GYk/veeze.jpg',
            audioLink: 'assets/music/veeze.mp3'
        }
    },


    InitialMusicVolume: 0.1, // The volume will be saved on client, this is only for the first time loading the screen


    announcementsPreview: { // The container at the botton right
        title: 'Announcements', // The title of the container
        highlight: 'New Content', // The highlight of the container
        image: 'https://www.rockstargames.com/VI/_next/image?url=%2FVI%2F_next%2Fstatic%2Fmedia%2FJason_and_Lucia_02_ultrawide.915c382b.jpg&w=1920&q=75' // The cover image of the container
    },


    announcements: { // You can add more or remove announcements. if you don't need it entirely, look at elements at line 101
        1: {
            image: 'https://i.ibb.co/nM1VH3N7/update-1-9-5.png', // The image of the announcement, Use link or relative directory if local
            title: 'Version 1.9.5', // The title of the announcement
            date: 'Sep 20, 2025', // The data of the announcement
            content: 'The main target of this update is the trust system w/ new features and data handling methods, resulting in better optimization. There are also quality of life updates like character name changes, poll voting system, pre-made events, new announcement interface, & more!'
        },
        2: {
            image: 'https://i.ibb.co/d4yvgP3b/update-1-9-0.png', // The image of the announcement, Use link or relative directory if local
            title: 'Version 1.9.0', // The title of the announcement
            date: 'Aug 22, 2025', // The data of the announcement
            content: 'The main target of this update is the more public legal & illegal actvities. There are also quality of life updates like peace time, guide book, movement improvements & more!'
        },
    },


    socials: { // Leave each empty if you don't need them.
        instagram: '',
        tiktok: 'https://tiktok.com/@leanedoutroleplay',
        youtube: '',
        discord: 'https://discord.gg/lorp',
        website: 'https://lorp.tebex.io',
        reddit: '',
        wiki: '',
        x: '',
        twitch: '',
        onlyfans: '' // LOL
    },


    colors: { // Color customizations
        darkModePrimary: '#cde6ff', // Primary color while in dark mode
        darkModePrimaryMix: '#667380', // Primary mix color while in dark mode
        lightModePrimary: '#1e2026', // Primary color while in light mode
        lightModePrimaryMix: '#0e0f12', // Primary mix color while in light mode
        explicitPrimary: '#cde6ff',  // The explicit primary color
        explicitPrimaryMix: '#667380', // The explicit primary mix color
        tint: '#b9dcff', // Tint color on images - If you don't need tint at all look at visuals at line 92
        dark: '#0e0f12', // Dark color mainly used in dark mode
        light: '#cde6ff', // Light color mainly used in light mode
    },


    visuals: { // Visuals customizations
        vignette: false,
        tint: true,
        blackAndWhite: false,
        brightness: 0.8,
        panelsBlur: 10 // The background blur of the panels. more value = more blur. to disable blur completely set this to 0
    },


    elements: { // Wether each element exist or not
        socials: true,
        announcements: true,
        user: true,
        logo: true,
        lightAndDarkMode: true,
        progressbar: true
    },


    labels: { // Text labels for translations
        connecting: 'Joining as...',
    },
};
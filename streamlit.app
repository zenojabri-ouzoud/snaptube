<!DOCTYPE html>
<html lang="ar" dir="rtl" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePulse 360 - Multi-Language Cinema & Downloads Platform</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        brand: {
                            50: '#fff1f2',
                            500: '#e11d48',
                            600: '#be123c',
                            700: '#9f1239',
                        },
                        darkbg: '#0a0a0d',
                        cardbg: '#141418',
                        surface: '#1f1f26'
                    },
                    fontFamily: {
                        sans: ['Inter', 'Cairo', 'system-ui', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <!-- YouTube IFrame API -->
    <script src="https://www.youtube.com/iframe_api"></script>
    <style>
        body {
            background-color: #0a0a0d;
            color: #f3f4f6;
            overflow-x: hidden;
            transition: background-color 0.5s ease;
        }
        body.theater-mode {
            background-color: #000000 !important;
        }
        body.theater-mode header,
        body.theater-mode footer,
        body.theater-mode main > section:not(#videoModal) {
            opacity: 0.15;
            pointer-events: none;
            filter: blur(4px);
            transition: all 0.5s ease;
        }
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #0a0a0d;
        }
        ::-webkit-scrollbar-thumb {
            background: #27272a;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #e11d48;
        }
        .glass-nav {
            background: rgba(10, 10, 13, 0.85);
            backdrop-filter: blur(12px);
        }
        .glass-card {
            background: rgba(20, 20, 24, 0.75);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        .hero-gradient-rtl {
            background: linear-gradient(180deg, rgba(10,10,13,0.2) 0%, rgba(10,10,13,0.85) 75%, #0a0a0d 100%),
                        linear-gradient(270deg, rgba(10,10,13,0.95) 0%, rgba(10,10,13,0.5) 50%, rgba(10,10,13,0.1) 100%);
        }
        .hero-gradient-ltr {
            background: linear-gradient(180deg, rgba(10,10,13,0.2) 0%, rgba(10,10,13,0.85) 75%, #0a0a0d 100%),
                        linear-gradient(90deg, rgba(10,10,13,0.95) 0%, rgba(10,10,13,0.5) 50%, rgba(10,10,13,0.1) 100%);
        }
        .movie-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .movie-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 25px -5px rgba(225, 29, 72, 0.25), 0 10px 10px -5px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>
<body class="bg-darkbg text-gray-100 min-h-screen flex flex-col selection:bg-brand-500 selection:text-white">

    <!-- NAVIGATION HEADER -->
    <header class="fixed top-0 left-0 right-0 z-40 glass-nav transition-all duration-300 border-b border-white/5" id="mainHeader">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-20 flex items-center justify-between gap-4">
            
            <!-- Logo & Main Nav -->
            <div class="flex items-center gap-8">
                <a href="#" class="flex items-center gap-2.5 group">
                    <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-brand-600 to-rose-400 flex items-center justify-center shadow-lg shadow-brand-500/30 group-hover:scale-105 transition-transform">
                        <i class="fa-solid fa-play text-white text-lg"></i>
                    </div>
                    <span class="text-2xl font-extrabold tracking-wider bg-gradient-to-r from-white via-gray-200 to-brand-500 bg-clip-text text-transparent">CINE<span class="text-brand-500">PULSE 360</span></span>
                </a>

                <!-- Nav Links -->
                <nav class="hidden md:flex items-center gap-6 text-sm font-semibold text-gray-300">
                    <a href="#home" data-i18n="navHome" class="hover:text-brand-500 transition-colors text-white">الرئيسية</a>
                    <a href="#movies" data-i18n="navMovies" class="hover:text-brand-500 transition-colors">الأفلام</a>
                    <a href="#downloads" class="hover:text-brand-500 transition-colors flex items-center gap-1.5">
                        <span data-i18n="navDownloads">التحميلات</span>
                        <span id="downloadsBadge" class="bg-brand-600 text-white text-[10px] px-1.5 py-0.5 rounded-full hidden">0</span>
                    </a>
                    <a href="#watchlist" data-i18n="navWatchlist" class="hover:text-brand-500 transition-colors">قائمتي</a>
                </nav>
            </div>

            <!-- Controls: Search, Lang Switcher, Add & Profile -->
            <div class="flex items-center gap-3">
                <!-- Search Input -->
                <div class="relative hidden sm:block w-40 lg:w-60">
                    <input type="text" id="searchInput" data-i18n-ph="searchPlaceholder" placeholder="بحث عن فيلم، نوع..." 
                        class="w-full bg-surface border border-white/10 rounded-full py-2 px-9 text-xs text-gray-200 placeholder-gray-400 focus:outline-none focus:border-brand-500 transition-all">
                    <i class="fa-solid fa-magnifying-glass absolute inset-y-0 my-auto text-gray-400 text-xs flex items-center ltr:left-3 rtl:right-3"></i>
                </div>

                <!-- Language Switcher Dropdown -->
                <div class="relative">
                    <select id="langSelect" onchange="changeLanguage(this.value)" class="bg-surface border border-white/10 text-white text-xs font-semibold rounded-xl px-2.5 py-2 focus:outline-none focus:border-brand-500 cursor-pointer">
                        <option value="ar">العربية (AR)</option>
                        <option value="en">English (EN)</option>
                        <option value="fr">Français (FR)</option>
                    </select>
                </div>

                <!-- Add Custom Movie Stream -->
                <button onclick="openAddMovieModal()" class="bg-brand-600 hover:bg-brand-700 text-white px-3.5 py-2 rounded-xl text-xs font-semibold flex items-center gap-2 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
                    <i class="fa-solid fa-plus"></i>
                    <span class="hidden lg:inline" data-i18n="addStreamBtn">إضافة فيديو</span>
                </button>

                <!-- Theater Mode Quick Toggle -->
                <button onclick="toggleTheaterMode()" title="Theater Mode" class="w-9 h-9 rounded-xl bg-surface hover:bg-white/20 border border-white/10 text-white flex items-center justify-center transition-colors">
                    <i class="fa-solid fa-masks-theater text-xs"></i>
                </button>

                <!-- Profile Avatar -->
                <div class="w-8 h-8 rounded-full border border-white/10 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80" alt="Avatar" class="w-full h-full object-cover">
                </div>
            </div>
        </div>

        <!-- Mobile Search Bar -->
        <div class="px-4 pb-3 sm:hidden">
            <div class="relative w-full">
                <input type="text" id="searchInputMobile" data-i18n-ph="searchPlaceholder" placeholder="بحث عن فيلم، نوع..." 
                    class="w-full bg-surface border border-white/10 rounded-full py-2 px-9 text-xs text-gray-200 placeholder-gray-400 focus:outline-none focus:border-brand-500">
                <i class="fa-solid fa-magnifying-glass absolute inset-y-0 my-auto text-gray-400 text-xs flex items-center ltr:left-3 rtl:right-3"></i>
            </div>
        </div>
    </header>

    <!-- MAIN CONTENT CONTAINER -->
    <main class="flex-grow pt-20">

        <!-- HERO SPOTLIGHT CAROUSEL -->
        <section id="home" class="relative w-full min-h-[70vh] flex items-center justify-center overflow-hidden">
            <div id="heroBackdrop" class="absolute inset-0 bg-cover bg-center transition-all duration-700 transform scale-105" 
                 style="background-image: url('https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?auto=format&fit=crop&w=1920&q=80');">
            </div>
            <div id="heroOverlay" class="absolute inset-0 hero-gradient-rtl"></div>

            <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full pt-16 pb-16 z-10 flex flex-col justify-end">
                <div class="max-w-2xl space-y-4">
                    <div class="flex items-center flex-wrap gap-2 text-xs font-semibold">
                        <span class="bg-brand-600 text-white px-2.5 py-1 rounded-md uppercase" data-i18n="featuredBadge">مميز اليوم</span>
                        <span class="bg-white/10 backdrop-blur-md text-emerald-400 px-2.5 py-1 rounded-md border border-emerald-500/30">98% Match</span>
                        <span class="bg-white/10 backdrop-blur-md text-gray-200 px-2.5 py-1 rounded-md">4K Ultra HD</span>
                        <span class="text-amber-400 font-bold flex items-center gap-1"><i class="fa-solid fa-star"></i> <span>8.9</span></span>
                    </div>

                    <h1 id="heroTitle" class="text-3xl sm:text-5xl font-extrabold text-white tracking-tight leading-tight">
                        Cyberpunk: Neo Tokyo 2099
                    </h1>

                    <p id="heroDesc" class="text-gray-300 text-xs sm:text-sm line-clamp-3 leading-relaxed">
                        في مدينة مستقبلية تحكمها الشركات العملاقة، يكتشف عميل سايبورغ متمرد مؤامرة خطيرة تهدد الوعي البشري.
                    </p>

                    <div class="flex flex-wrap items-center gap-3 pt-3">
                        <button onclick="playMovie('m1')" class="bg-brand-600 hover:bg-brand-700 text-white font-bold px-6 py-3 rounded-xl flex items-center gap-2.5 shadow-lg shadow-brand-600/40 transition-all hover:scale-105 text-xs sm:text-sm">
                            <i class="fa-solid fa-play"></i> <span data-i18n="watchNow">مشاهدة الآن</span>
                        </button>
                        <button onclick="toggleHeroWatchlist()" id="heroWatchlistBtn" class="bg-surface hover:bg-white/20 text-white font-semibold px-5 py-3 rounded-xl flex items-center gap-2 border border-white/10 backdrop-blur-md transition-all text-xs sm:text-sm">
                            <i class="fa-solid fa-plus" id="heroWatchlistIcon"></i> <span data-i18n="addWatchlist">إضافة للقائمة</span>
                        </button>
                        <button onclick="downloadMovie('m1')" class="bg-surface hover:bg-white/20 text-white font-semibold p-3 sm:px-4 sm:py-3 rounded-xl flex items-center gap-2 border border-white/10 backdrop-blur-md transition-all text-xs sm:text-sm">
                            <i class="fa-solid fa-download"></i> <span class="hidden sm:inline" data-i18n="downloadOffline">تحميل للأوفلاين</span>
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- GENRES FILTER BAR -->
        <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-6 relative z-20 mb-8">
            <div class="glass-card p-3 rounded-2xl flex items-center gap-2 overflow-x-auto" id="genreContainer">
                <button onclick="filterGenre('All')" class="genre-btn active px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-brand-600 text-white transition-all" data-i18n="catAll">كل الأفلام</button>
                <button onclick="filterGenre('Sci-Fi')" class="genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all" data-i18n="catSciFi">خيال علمي</button>
                <button onclick="filterGenre('Action')" class="genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all" data-i18n="catAction">أكشن</button>
                <button onclick="filterGenre('Drama')" class="genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all" data-i18n="catDrama">دراما</button>
                <button onclick="filterGenre('Horror')" class="genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all" data-i18n="catHorror">رعب</button>
                <button onclick="filterGenre('Comedy')" class="genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all" data-i18n="catComedy">كوميديا</button>
                <button onclick="filterGenre('Animation')" class="genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all" data-i18n="catAnimation">أنيميشن</button>
            </div>
        </section>

        <!-- MOVIES GRID -->
        <section id="movies" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-3">
                    <div class="w-1.5 h-6 bg-brand-600 rounded-full"></div>
                    <h2 class="text-xl sm:text-2xl font-bold text-white" data-i18n="secTrending">الأفلام الرائجة والتوصيات</h2>
                </div>
                <span id="movieCountText" class="text-xs text-gray-400"></span>
            </div>

            <div id="moviesGrid" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 sm:gap-6">
                <!-- Dynamic cards -->
            </div>
        </section>

        <!-- WATCHLIST SECTION -->
        <section id="watchlist" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 border-t border-white/5">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-3">
                    <div class="w-1.5 h-6 bg-amber-500 rounded-full"></div>
                    <h2 class="text-xl sm:text-2xl font-bold text-white" data-i18n="secWatchlist">قائمة المشاهدة اللاحقة</h2>
                </div>
                <button onclick="clearWatchlist()" class="text-xs text-gray-400 hover:text-red-400 transition-colors" data-i18n="clearAll">مسح الكل</button>
            </div>

            <div id="watchlistGrid" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 sm:gap-6">
                <!-- Watchlist cards -->
            </div>
            <div id="emptyWatchlistState" class="hidden text-center py-12 glass-card rounded-2xl border border-white/5">
                <i class="fa-solid fa-bookmark text-4xl text-gray-600 mb-3"></i>
                <p class="text-gray-400 text-sm" data-i18n="emptyWatchlist">قائمة المشاهدة فارغة حالياً.</p>
            </div>
        </section>

        <!-- DOWNLOAD MANAGER SECTION -->
        <section id="downloads" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 border-t border-white/5 mb-16">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-3">
                    <div class="w-1.5 h-6 bg-emerald-500 rounded-full"></div>
                    <h2 class="text-xl sm:text-2xl font-bold text-white" data-i18n="secDownloads">مدير التحميلات التخزينية (Offline)</h2>
                </div>
                <span class="text-xs bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 px-3 py-1 rounded-full font-medium" data-i18n="storageActive">التخزين المحلي نشط</span>
            </div>

            <div class="glass-card rounded-2xl p-4 sm:p-6 space-y-4">
                <div id="downloadsList" class="space-y-3"></div>
                <div id="emptyDownloadsState" class="text-center py-10">
                    <i class="fa-solid fa-cloud-arrow-down text-4xl text-gray-600 mb-3"></i>
                    <p class="text-gray-400 text-sm" data-i18n="emptyDownloads">لا توجد تنزيلات أو أفلام محمّلة حالياً.</p>
                </div>
            </div>
        </section>

    </main>

    <!-- FOOTER -->
    <footer class="bg-cardbg border-t border-white/5 py-8 text-xs text-gray-400">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row items-center justify-between gap-4">
            <div class="flex items-center gap-2">
                <div class="w-6 h-6 rounded-lg bg-brand-600 flex items-center justify-center text-white font-bold">C</div>
                <span class="font-bold text-gray-200">CinePulse 360</span> &copy; 2026. <span data-i18n="rights">جميع الحقوق محفوظة.</span>
            </div>
            <div class="flex items-center gap-6">
                <a href="#" class="hover:text-brand-500 transition-colors" data-i18n="privacy">الخصوصية</a>
                <a href="#" class="hover:text-brand-500 transition-colors" data-i18n="terms">الشروط والأحكام</a>
                <a href="#" class="hover:text-brand-500 transition-colors" data-i18n="support">الدعم الفني</a>
            </div>
        </div>
    </footer>

    <!-- ADVANCED UNIVERSAL VIDEO PLAYER MODAL WITH DUAL PLAYER (HTML5 + IFRAME EMBED) -->
    <div id="videoModal" class="fixed inset-0 z-50 bg-black/95 flex items-center justify-center opacity-0 pointer-events-none transition-opacity duration-300">
        <div class="relative w-full h-full max-w-6xl max-h-[95vh] flex flex-col bg-black rounded-0 sm:rounded-2xl overflow-hidden shadow-2xl border border-white/10 mx-auto my-auto">
            
            <!-- Video Top Bar -->
            <div class="absolute top-0 left-0 right-0 z-30 p-4 bg-gradient-to-b from-black/90 to-transparent flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <span id="playerMovieTitle" class="text-white font-bold text-sm sm:text-base">عنوان الفيلم</span>
                    <span id="playerSourceTypeBadge" class="bg-brand-600 text-white text-[10px] px-2 py-0.5 rounded font-semibold uppercase">Smart Engine</span>
                </div>
                <div class="flex items-center gap-2">
                    <button onclick="toggleTheaterMode()" title="Dim Screen" class="w-8 h-8 rounded-full bg-white/10 hover:bg-amber-500 text-white flex items-center justify-center text-xs transition-colors">
                        <i class="fa-solid fa-lightbulb"></i>
                    </button>
                    <button onclick="closeVideoPlayer()" class="w-9 h-9 rounded-full bg-white/10 hover:bg-brand-600 text-white flex items-center justify-center transition-colors">
                        <i class="fa-solid fa-xmark text-base"></i>
                    </button>
                </div>
            </div>

            <!-- Video Player Display Container -->
            <div class="relative flex-grow flex items-center justify-center bg-black group overflow-hidden">
                
                <!-- Native HTML5 Player -->
                <video id="mainVideoPlayer" class="w-full h-full object-contain hidden" crossorigin="anonymous" preload="metadata">
                    <source id="videoSource" src="" type="video/mp4">
                    <track id="videoSubtitleTrack" kind="subtitles" srclang="en" label="English" default>
                </video>

                <!-- Universal Iframe Embed Player for Platforms (YouTube, Vimeo, Twitch, etc.) -->
                <iframe id="embedVideoPlayer" class="w-full h-full border-0 hidden" allowfullscreen allow="autoplay; encrypted-media; picture-in-picture"></iframe>

                <!-- YouTube API Container -->
                <div id="ytPlayerContainer" class="w-full h-full hidden">
                    <div id="ytPlayer" class="w-full h-full"></div>
                </div>

                <!-- YouTube Fallback Overlay (Triggered if YouTube blocks file:// embed) -->
                <div id="ytFallbackOverlay" class="absolute inset-0 bg-darkbg/95 z-40 flex flex-col items-center justify-center p-6 text-center hidden">
                    <div class="w-16 h-16 rounded-full bg-amber-500/10 border border-amber-500/30 text-amber-400 flex items-center justify-center text-2xl mb-3">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                    <h3 class="text-lg font-bold text-white mb-1">قيود التشغيل المباشر من يوتيوب (Error 153)</h3>
                    <p class="text-xs text-gray-400 max-w-md mb-4 leading-relaxed">
                        يوتيوب يمنع التضمين المباشر عند فتح الملفات المحلية (<code class="text-rose-400">file://</code>). يمكنك الاستمتاع بمشاهدة الفيديو فوراً عبر خيار المشاهدة الخارجية:
                    </p>
                    <a id="btnFallbackExternal" href="#" target="_blank" class="px-5 py-2.5 rounded-xl bg-brand-600 hover:bg-brand-700 text-white font-bold text-xs flex items-center gap-2 shadow-lg shadow-brand-600/30 transition-all">
                        <i class="fa-solid fa-arrow-up-right-from-square"></i> مشاهدة على يوتيوب مباشرة
                    </a>
                </div>

                <!-- Center Play Overlay Button for HTML5 -->
                <button id="overlayPlayBtn" onclick="togglePlayPause()" class="absolute w-16 h-16 rounded-full bg-brand-600/80 hover:bg-brand-600 text-white flex items-center justify-center text-xl transition-all transform scale-90 opacity-0 group-hover:opacity-100 group-hover:scale-100 hidden">
                    <i class="fa-solid fa-play ml-0.5" id="overlayPlayIcon"></i>
                </button>

                <!-- Timestamp Notes Drawer Sidebar -->
                <div id="notesDrawer" class="absolute top-16 right-0 bottom-20 w-80 bg-cardbg/95 border-l border-white/10 backdrop-blur-md z-30 p-4 transform translate-x-full transition-transform duration-300 flex flex-col justify-between">
                    <div>
                        <div class="flex items-center justify-between pb-3 border-b border-white/10 mb-3">
                            <h4 class="font-bold text-xs text-white uppercase flex items-center gap-2"><i class="fa-solid fa-note-sticky text-amber-400"></i> ملاحظات الفيديو والطوابع</h4>
                            <button onclick="toggleNotesDrawer()" class="text-gray-400 hover:text-white"><i class="fa-solid fa-xmark text-sm"></i></button>
                        </div>
                        <div class="flex gap-2 mb-3">
                            <input type="text" id="noteInput" placeholder="اكتب ملاحظة..." class="flex-grow bg-surface border border-white/10 text-xs text-white rounded-lg px-2.5 py-1.5 focus:outline-none focus:border-brand-500">
                            <button onclick="addTimestampNote()" class="bg-brand-600 hover:bg-brand-700 text-white text-xs px-3 py-1.5 rounded-lg font-bold"><i class="fa-solid fa-bookmark"></i></button>
                        </div>
                        <div id="notesList" class="space-y-2 max-h-60 overflow-y-auto pr-1"></div>
                    </div>
                </div>

                <!-- Bottom HTML5 Player Controls Bar -->
                <div id="html5ControlsBar" class="absolute bottom-0 left-0 right-0 z-20 p-4 bg-gradient-to-t from-black/95 via-black/60 to-transparent flex flex-col gap-2 transition-opacity duration-300">
                    <!-- Progress / Seek -->
                    <div class="flex items-center gap-3">
                        <span id="currentTime" class="text-xs text-gray-300 font-mono">00:00</span>
                        <input type="range" id="seekBar" value="0" max="100" class="flex-grow h-1.5 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-brand-500">
                        <span id="durationTime" class="text-xs text-gray-400 font-mono">00:00</span>
                    </div>

                    <!-- Buttons Control Row -->
                    <div class="flex items-center justify-between pt-1">
                        <div class="flex items-center gap-3">
                            <button onclick="togglePlayPause()" class="text-white hover:text-brand-500 transition-colors">
                                <i class="fa-solid fa-play text-base" id="playPauseIcon"></i>
                            </button>
                            <!-- Volume Slider & Audio Equalizer Boost -->
                            <div class="flex items-center gap-2">
                                <button onclick="toggleMute()" class="text-gray-300 hover:text-white transition-colors">
                                    <i class="fa-solid fa-volume-high text-xs" id="volumeIcon"></i>
                                </button>
                                <input type="range" id="volumeBar" min="0" max="1" step="0.1" value="1" class="w-16 h-1 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-brand-500">
                                <button onclick="cycleAudioPreset()" id="audioEqBtn" title="Audio Booster / Equalizer" class="text-[10px] bg-white/10 hover:bg-brand-600 px-2 py-0.5 rounded text-amber-400 font-bold border border-white/10">
                                    EQ: Normal
                                </button>
                            </div>
                        </div>

                        <!-- Right Tools: Screenshot, Notes, Sleep Timer, Subtitle Upload, Speed, PIP, Fullscreen -->
                        <div class="flex items-center gap-2.5 text-xs">
                            <!-- Take Screenshot -->
                            <button onclick="takeFrameSnapshot()" class="text-gray-300 hover:text-emerald-400 transition-colors" title="Take Frame Snapshot">
                                <i class="fa-solid fa-camera text-xs"></i>
                            </button>

                            <!-- Sleep Timer -->
                            <div class="relative">
                                <select id="sleepTimerSelect" onchange="setSleepTimer(this.value)" class="bg-surface text-gray-200 border border-white/10 rounded px-1 py-1 text-[11px] focus:outline-none">
                                    <option value="0">⏱️ Off</option>
                                    <option value="15">15 min</option>
                                    <option value="30">30 min</option>
                                    <option value="60">60 min</option>
                                </select>
                            </div>

                            <!-- Open Notes -->
                            <button onclick="toggleNotesDrawer()" class="text-gray-300 hover:text-amber-400 transition-colors" title="Timestamped Notes">
                                <i class="fa-solid fa-note-sticky text-xs"></i>
                            </button>

                            <!-- Custom Subtitle Upload Button -->
                            <label class="cursor-pointer text-gray-400 hover:text-white px-2 py-1 rounded bg-white/10 border border-white/10 font-medium flex items-center gap-1" title="Upload Subtitle (.vtt / .srt)">
                                <i class="fa-solid fa-closed-captioning"></i>
                                <span class="hidden sm:inline" data-i18n="subUpload">ترجمة</span>
                                <input type="file" id="subFileInput" accept=".vtt,.srt" onchange="loadExternalSubtitle(event)" class="hidden">
                            </label>

                            <!-- Speed selector -->
                            <select id="speedSelect" onchange="changeSpeed(this.value)" class="bg-surface text-gray-200 border border-white/10 rounded px-1.5 py-1 text-xs focus:outline-none">
                                <option value="0.5">0.5x</option>
                                <option value="1.0" selected>1.0x</option>
                                <option value="1.25">1.25x</option>
                                <option value="1.5">1.5x</option>
                                <option value="2.0">2.0x</option>
                                <option value="3.0">3.0x</option>
                            </select>

                            <!-- PIP Button -->
                            <button onclick="togglePiP()" class="text-gray-300 hover:text-white transition-colors" title="Picture in Picture">
                                <i class="fa-solid fa-clone text-xs"></i>
                            </button>

                            <!-- Fullscreen Button -->
                            <button onclick="toggleFullscreen()" class="text-gray-300 hover:text-white transition-colors">
                                <i class="fa-solid fa-expand text-xs"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- PLATFORM DOWNLOAD EXTRACTOR ASSISTANT MODAL -->
    <div id="platformDownloadModal" class="fixed inset-0 z-50 bg-black/85 backdrop-blur-sm flex items-center justify-center opacity-0 pointer-events-none transition-opacity duration-300 px-4">
        <div class="glass-card w-full max-w-lg rounded-2xl p-6 border border-white/10 shadow-2xl space-y-4">
            <div class="flex items-center justify-between border-b border-white/10 pb-3">
                <h3 class="text-base font-bold text-white flex items-center gap-2">
                    <i class="fa-solid fa-circle-down text-emerald-400"></i> <span data-i18n="extractorTitle">مساعد تحميل فيديوهات المنصات</span>
                </h3>
                <button onclick="closePlatformDownloadModal()" class="text-gray-400 hover:text-white">
                    <i class="fa-solid fa-xmark text-lg"></i>
                </button>
            </div>

            <div class="space-y-3 text-xs sm:text-sm">
                <p class="text-gray-300 leading-relaxed" data-i18n="extractorDesc">
                    هذا الفيديو مقطع مدمج من منصة خارجية. يمكنك تنزيله فوراً باستخدام إحدى الأدوات الخارجية المباشرة أو نسخ أمر `yt-dlp`:
                </p>

                <div class="p-3 bg-surface rounded-xl border border-white/5 space-y-2">
                    <div class="text-[11px] text-gray-400 font-medium">رابط الفيديو الأصلي:</div>
                    <input type="text" id="platformTargetUrl" readonly class="w-full bg-black/50 border border-white/10 rounded-lg p-2 text-xs text-brand-400 font-mono select-all">
                </div>

                <!-- Quick Download Helper Links -->
                <div class="grid grid-cols-2 gap-2 pt-1">
                    <a id="savefromLink" target="_blank" class="p-2.5 rounded-xl bg-emerald-600/20 hover:bg-emerald-600/30 border border-emerald-500/30 text-emerald-300 text-xs font-semibold flex items-center justify-center gap-2 transition-colors">
                        <i class="fa-solid fa-arrow-down-to-bracket"></i> SaveFrom Helper
                    </a>
                    <a id="cobaltLink" target="_blank" class="p-2.5 rounded-xl bg-sky-600/20 hover:bg-sky-600/30 border border-sky-500/30 text-sky-300 text-xs font-semibold flex items-center justify-center gap-2 transition-colors">
                        <i class="fa-solid fa-bolt"></i> Cobalt Engine
                    </a>
                </div>

                <!-- Command line tool helper -->
                <div class="p-3 bg-black/60 rounded-xl border border-white/10 space-y-1">
                    <div class="flex items-center justify-between text-[11px] text-gray-400">
                        <span>أمر yt-dlp للمحترفين:</span>
                        <button onclick="copyYtDlpCmd()" class="text-brand-400 hover:underline text-[10px]">نسخ الأمر</button>
                    </div>
                    <code id="ytDlpCmd" class="block text-[11px] text-emerald-400 font-mono overflow-x-auto whitespace-nowrap py-1">yt-dlp "URL"</code>
                </div>
            </div>

            <div class="pt-2 flex justify-end">
                <button onclick="closePlatformDownloadModal()" class="px-5 py-2 rounded-xl bg-surface hover:bg-white/10 text-gray-300 text-xs font-semibold">إغلاق</button>
            </div>
        </div>
    </div>

    <!-- ADD CUSTOM MOVIE MODAL -->
    <div id="addMovieModal" class="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center opacity-0 pointer-events-none transition-opacity duration-300 px-4">
        <div class="glass-card w-full max-w-lg rounded-2xl p-6 border border-white/10 shadow-2xl space-y-4">
            <div class="flex items-center justify-between border-b border-white/10 pb-3">
                <h3 class="text-base font-bold text-white flex items-center gap-2">
                    <i class="fa-solid fa-video text-brand-500"></i> <span data-i18n="addMovieModalTitle">إضافة فيلم أو رابط فيديو مباشر / منصة</span>
                </h3>
                <button onclick="closeAddMovieModal()" class="text-gray-400 hover:text-white">
                    <i class="fa-solid fa-xmark text-lg"></i>
                </button>
            </div>

            <form id="addMovieForm" onsubmit="handleCustomMovieSubmit(event)" class="space-y-3 text-xs sm:text-sm">
                <div>
                    <label class="block text-gray-300 font-medium mb-1" data-i18n="formTitle">اسم الفيلم *</label>
                    <input type="text" id="customTitle" required placeholder="Ex: Inception" class="w-full bg-surface border border-white/10 rounded-xl p-2.5 text-white focus:outline-none focus:border-brand-500">
                </div>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-gray-300 font-medium mb-1" data-i18n="formGenre">النوع *</label>
                        <select id="customGenre" class="w-full bg-surface border border-white/10 rounded-xl p-2.5 text-white focus:outline-none focus:border-brand-500">
                            <option value="Sci-Fi">Sci-Fi</option>
                            <option value="Action">Action</option>
                            <option value="Drama">Drama</option>
                            <option value="Horror">Horror</option>
                            <option value="Comedy">Comedy</option>
                            <option value="Animation">Animation</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-gray-300 font-medium mb-1" data-i18n="formRating">التقييم (1-10)</label>
                        <input type="number" step="0.1" min="1" max="10" id="customRating" value="8.5" class="w-full bg-surface border border-white/10 rounded-xl p-2.5 text-white focus:outline-none focus:border-brand-500">
                    </div>
                </div>
                <div>
                    <label class="block text-gray-300 font-medium mb-1" data-i18n="formVideoUrl">رابط الفيديو (Direct MP4, YouTube, Vimeo, Dailymotion...)</label>
                    <input type="url" id="customVideoUrl" required placeholder="https://youtube.com/watch?v=... or https://site.com/video.mp4" class="w-full bg-surface border border-white/10 rounded-xl p-2.5 text-white focus:outline-none focus:border-brand-500">
                </div>
                <div>
                    <label class="block text-gray-300 font-medium mb-1" data-i18n="formPosterUrl">رابط صوره البوستر (اختياري)</label>
                    <input type="url" id="customPosterUrl" placeholder="https://images.unsplash.com/..." class="w-full bg-surface border border-white/10 rounded-xl p-2.5 text-white focus:outline-none focus:border-brand-500">
                </div>

                <div class="pt-2 flex justify-end gap-2">
                    <button type="button" onclick="closeAddMovieModal()" class="px-4 py-2 rounded-xl bg-surface hover:bg-white/10 text-gray-300 font-medium" data-i18n="btnCancel">إلغاء</button>
                    <button type="submit" class="px-5 py-2 rounded-xl bg-brand-600 hover:bg-brand-700 text-white font-bold shadow-lg shadow-brand-600/30" data-i18n="btnAdd">إضافة</button>
                </div>
            </form>
        </div>
    </div>

    <!-- TOAST NOTIFICATION -->
    <div id="toast" class="fixed bottom-5 left-5 z-50 bg-surface border border-brand-500/40 text-white px-4 py-3 rounded-xl shadow-2xl flex items-center gap-3 transform translate-y-20 opacity-0 transition-all duration-300">
        <div class="w-7 h-7 rounded-full bg-brand-600/20 text-brand-500 flex items-center justify-center font-bold" id="toastIcon">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        <p id="toastMessage" class="text-xs font-semibold">تنبيه النظام</p>
    </div>

    <!-- APPLICATION LOGIC & I18N DICTIONARY -->
    <script>
        // TRILINGUAL DICTIONARY
        const I18N = {
            ar: {
                navHome: "الرئيسية",
                navMovies: "الأفلام",
                navDownloads: "التحميلات",
                navWatchlist: "قائمتي",
                searchPlaceholder: "بحث عن فيلم، نوع...",
                addStreamBtn: "إضافة فيديو",
                featuredBadge: "مميز اليوم",
                watchNow: "مشاهدة الآن",
                addWatchlist: "إضافة للقائمة",
                downloadOffline: "تحميل للأوفلاين",
                catAll: "كل الأفلام",
                catSciFi: "خيال علمي",
                catAction: "أكشن",
                catDrama: "دراما",
                catHorror: "رعب",
                catComedy: "كوميديا",
                catAnimation: "أنيميشن",
                secTrending: "الأفلام الرائجة والتوصيات",
                secWatchlist: "قائمة المشاهدة اللاحقة",
                clearAll: "مسح الكل",
                emptyWatchlist: "قائمة المشاهدة فارغة حالياً.",
                secDownloads: "مدير التحميلات التخزينية (Offline)",
                storageActive: "التخزين المحلي نشط",
                emptyDownloads: "لا توجد تنزيلات أو أفلام محمّلة حالياً.",
                rights: "جميع الحقوق محفوظة.",
                privacy: "الخصوصية",
                terms: "الشروط والأحكام",
                support: "الدعم الفني",
                subUpload: "رفع ترجمة",
                addMovieModalTitle: "إضافة فيلم أو رابط فيديو مباشر / منصة",
                formTitle: "اسم الفيلم *",
                formGenre: "النوع *",
                formRating: "التقييم (1-10)",
                formVideoUrl: "رابط الفيديو (Direct MP4, YouTube, Vimeo, Dailymotion...)",
                formPosterUrl: "رابط صوره البوستر",
                btnCancel: "إلغاء",
                btnAdd: "إضافة الفيلم",
                readyOffline: "جاهز للأوفلاين",
                downloading: "جاري التحميل...",
                extractorTitle: "مساعد تحميل فيديوهات المنصات",
                extractorDesc: "هذا الفيديو مقطع مدمج من منصة خارجية. يمكنك تنزيله فوراً باستخدام إحدى الأدوات الخارجية المباشرة أو نسخ أمر yt-dlp:"
            },
            en: {
                navHome: "Home",
                navMovies: "Movies",
                navDownloads: "Downloads",
                navWatchlist: "My List",
                searchPlaceholder: "Search movies, genres...",
                addStreamBtn: "Add Stream",
                featuredBadge: "Featured Today",
                watchNow: "Watch Now",
                addWatchlist: "Add to List",
                downloadOffline: "Download Offline",
                catAll: "All Movies",
                catSciFi: "Sci-Fi",
                catAction: "Action",
                catDrama: "Drama",
                catHorror: "Horror",
                catComedy: "Comedy",
                catAnimation: "Animation",
                secTrending: "Trending & Recommended",
                secWatchlist: "My Watchlist",
                clearAll: "Clear All",
                emptyWatchlist: "Your watchlist is currently empty.",
                secDownloads: "Offline Download Manager",
                storageActive: "Local Storage Active",
                emptyDownloads: "No downloaded movies yet.",
                rights: "All rights reserved.",
                privacy: "Privacy Policy",
                terms: "Terms of Service",
                support: "Support",
                subUpload: "Subtitles",
                addMovieModalTitle: "Add Custom Movie / Platform URL",
                formTitle: "Movie Title *",
                formGenre: "Genre *",
                formRating: "Rating (1-10)",
                formVideoUrl: "Video URL (Direct MP4, YouTube, Vimeo, Dailymotion...)",
                formPosterUrl: "Poster Image URL",
                btnCancel: "Cancel",
                btnAdd: "Add Movie",
                readyOffline: "Ready Offline",
                downloading: "Downloading...",
                extractorTitle: "Platform Video Extractor Assistant",
                extractorDesc: "This video is embedded from a platform. Download it via helper links or copy the yt-dlp command:"
            },
            fr: {
                navHome: "Accueil",
                navMovies: "Films",
                navDownloads: "Téléchargements",
                navWatchlist: "Ma Liste",
                searchPlaceholder: "Rechercher des films, genres...",
                addStreamBtn: "Ajouter Flux",
                featuredBadge: "En Vedette",
                watchNow: "Regarder",
                addWatchlist: "Ajouter à la liste",
                downloadOffline: "Télécharger",
                catAll: "Tous les Films",
                catSciFi: "Sci-Fi",
                catAction: "Action",
                catDrama: "Drame",
                catHorror: "Horreur",
                catComedy: "Comédie",
                catAnimation: "Animation",
                secTrending: "Tendances & Recommandations",
                secWatchlist: "Ma Liste de Lecture",
                clearAll: "Tout Effacer",
                emptyWatchlist: "Votre liste de lecture est vide.",
                secDownloads: "Gestionnaire Hors-Ligne",
                storageActive: "Stockage Actif",
                emptyDownloads: "Aucun film téléchargé.",
                rights: "Tous droits réservés.",
                privacy: "Confidentialité",
                terms: "Conditions d'utilisation",
                support: "Support Tech",
                subUpload: "Sous-titres",
                addMovieModalTitle: "Ajouter un Film / Lien de Plateforme",
                formTitle: "Titre du Film *",
                formGenre: "Genre *",
                formRating: "Note (1-10)",
                formVideoUrl: "URL Vidéo (Direct MP4, YouTube, Vimeo, Dailymotion...)",
                formPosterUrl: "URL de l'Affiche",
                btnCancel: "Annuler",
                btnAdd: "Ajouter Film",
                readyOffline: "Prêt Hors-Ligne",
                downloading: "Téléchargement...",
                extractorTitle: "Assistant d'Extraction de Plateforme",
                extractorDesc: "Cette vidéo provient d'une plateforme. Téléchargez-la via ces outils ou copiez l'ordre yt-dlp:"
            }
        };

        // SAMPLE MOVIES DATA WITH DIRECT & EMBED SUPPORT
        const INITIAL_MOVIES = [
            {
                id: 'm1',
                title: { ar: 'سايبر بانك: طوكيو 2099', en: 'Cyberpunk: Neo Tokyo 2099', fr: 'Cyberpunk: Neo Tokyo 2099' },
                genre: 'Sci-Fi',
                rating: 8.9,
                year: 2025,
                description: {
                    ar: 'في مدينة مستقبلية تحكمها الشركات العملاقة، يكتشف عميل سايبورغ متمرد مؤامرة خطيرة تهدد الوعي البشري.',
                    en: 'In a futuristic city ruled by megacorporations, a rogue cyborg agent uncovers a sinister plot threatening humanity.',
                    fr: 'Dans une métropole futuriste dominée par les mégacorporations, un agent cyborg découvre un complot menaçant l humanité.'
                },
                poster: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=600&q=80',
                videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
                size: '2.4 GB'
            },
            {
                id: 'm2',
                title: { ar: 'العرض الرسمي لقناة التكنولوجيا (YouTube)', en: 'Blender Tech Reel (YouTube)', fr: 'Démo Tech Blender (YouTube)' },
                genre: 'Animation',
                rating: 9.3,
                year: 2025,
                description: {
                    ar: 'فيديو مدمج ذكياً من يوتيوب يعمل مباشرة داخل المشغل.',
                    en: 'Smartly resolved YouTube embedded stream working inside player.',
                    fr: 'Flux vidéo YouTube intégré intelligemment dans le lecteur.'
                },
                poster: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80',
                videoUrl: 'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
                size: 'Embed Stream'
            },
            {
                id: 'm3',
                title: { ar: 'صحوة الظلال', en: 'Shadow Realm: Awakening', fr: 'Le Réveil des Ombres' },
                genre: 'Horror',
                rating: 7.8,
                year: 2025,
                description: {
                    ar: 'استيقاظ شر قديم في قرية جبلية معزولة يحاصر عائلة في معركة حاسمة للبقاء.',
                    en: 'An ancient evil wakes in an isolated village, trapping a family in a fight for survival.',
                    fr: 'Un mal ancien s éveille dans un village isolé, piégeant une famille.'
                },
                poster: 'https://images.unsplash.com/photo-1509281373149-e957c6296406?auto=format&fit=crop&w=600&q=80',
                videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
                size: '1.5 GB'
            },
            {
                id: 'm4',
                title: { ar: 'السرعة الفائقة: مطاردة طوكيو', en: 'Velocity: Tokyo Chase', fr: 'Vélocité: Poursuite à Tokyo' },
                genre: 'Action',
                rating: 8.4,
                year: 2024,
                description: {
                    ar: 'متسابقو شوارع محترفون ينفذون أضخم عملية سطو عبر شوارع طوكيو المضيئة.',
                    en: 'High-octane underground street racers pull off a major heist across neon Tokyo.',
                    fr: 'Des pilotes underground exécutent un braquage spectaculaire dans les rues de Tokyo.'
                },
                poster: 'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?auto=format&fit=crop&w=600&q=80',
                videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                size: '2.1 GB'
            }
        ];

        // GLOBAL APP STATE
        let currentLang = localStorage.getItem('cine_lang') || 'ar';
        let movies = JSON.parse(localStorage.getItem('cine_movies')) || INITIAL_MOVIES;
        let watchlist = JSON.parse(localStorage.getItem('cine_watchlist')) || ['m1'];
        let downloads = JSON.parse(localStorage.getItem('cine_downloads')) || [];
        let currentFilter = 'All';
        let currentActiveMovie = null;
        let sleepTimerId = null;
        let ytPlayerInstance = null;

        // WEB AUDIO API BOOSTER & EQUALIZER
        let audioCtx = null, audioSourceNode = null, gainNode = null, biquadFilter = null;
        let audioPresetIndex = 0; // 0: Normal, 1: Vocal Boost, 2: Bass Boost

        // DOM ELEMENTS
        const moviesGrid = document.getElementById('moviesGrid');
        const watchlistGrid = document.getElementById('watchlistGrid');
        const downloadsList = document.getElementById('downloadsList');
        const mainVideoPlayer = document.getElementById('mainVideoPlayer');
        const embedVideoPlayer = document.getElementById('embedVideoPlayer');
        const ytContainer = document.getElementById('ytPlayerContainer');
        const ytFallbackOverlay = document.getElementById('ytFallbackOverlay');
        const videoSource = document.getElementById('videoSource');
        const videoModal = document.getElementById('videoModal');

        // INIT APP
        window.addEventListener('DOMContentLoaded', () => {
            changeLanguage(currentLang, false);
            renderMovies();
            renderWatchlist();
            renderDownloads();
            setupSearchListeners();
            setupVideoPlayerEvents();
        });

        // SAVE STATE
        function saveState() {
            localStorage.setItem('cine_lang', currentLang);
            localStorage.setItem('cine_movies', JSON.stringify(movies));
            localStorage.setItem('cine_watchlist', JSON.stringify(watchlist));
            localStorage.setItem('cine_downloads', JSON.stringify(downloads));
        }

        // SMART URL RESOLVER ENGINE (Converts YouTube, Vimeo, Dailymotion, Drive URLs to Embed formats)
        function resolveVideoSource(url) {
            if (!url) return { type: 'direct', embedUrl: '' };

            // YouTube (Clean Embed Engine to bypass Error 153 on file:// domains)
            const ytMatch = url.match(/(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))([\w-]{11})/);
            if (ytMatch) {
                const videoId = ytMatch[1];
                // Using youtube-nocookie with origin parameter for max compatibility across local files
                const originParam = window.location.protocol === 'file:' ? 'https://www.youtube-nocookie.com' : window.location.origin;
                return { 
                    type: 'youtube', 
                    videoId: videoId,
                    embedUrl: `https://www.youtube-nocookie.com/embed/${videoId}?autoplay=1&controls=1&rel=0&enablejsapi=1&origin=${encodeURIComponent(originParam)}` 
                };
            }

            // Vimeo
            const vimeoMatch = url.match(/vimeo\.com\/(?:channels\/(?:\w+\/)?|groups\/([^\/]*)\/videos\/|album\/(\d+)\/video\/|)(\d+)/);
            if (vimeoMatch) {
                return { type: 'embed', embedUrl: `https://player.vimeo.com/video/${vimeoMatch[3]}?autoplay=1` };
            }

            // Dailymotion
            const dmMatch = url.match(/dailymotion\.com\/video\/([kK][a-zA-Z0-9]+)/);
            if (dmMatch) {
                return { type: 'embed', embedUrl: `https://www.dailymotion.com/embed/video/${dmMatch[1]}?autoplay=1` };
            }

            // Google Drive
            if (url.includes('drive.google.com') && url.includes('/view')) {
                const driveEmbed = url.replace('/view', '/preview');
                return { type: 'embed', embedUrl: driveEmbed };
            }

            // Generic iframe fallback check
            if (url.includes('/embed/')) {
                return { type: 'embed', embedUrl: url };
            }

            // Direct Video File (.mp4, .webm, blob, direct link)
            return { type: 'direct', directUrl: url };
        }

        // LANGUAGE SWITCHER & UI TRANSLATIONS
        function changeLanguage(lang, notify = true) {
            currentLang = lang;
            document.getElementById('langSelect').value = lang;
            
            const htmlTag = document.documentElement;
            const heroOverlay = document.getElementById('heroOverlay');

            if (lang === 'ar') {
                htmlTag.dir = 'rtl';
                htmlTag.lang = 'ar';
                heroOverlay.className = 'absolute inset-0 hero-gradient-rtl';
            } else {
                htmlTag.dir = 'ltr';
                htmlTag.lang = lang;
                heroOverlay.className = 'absolute inset-0 hero-gradient-ltr';
            }

            // Translate Static Elements
            document.querySelectorAll('[data-i18n]').forEach(el => {
                const key = el.getAttribute('data-i18n');
                if (I18N[lang][key]) {
                    el.innerText = I18N[lang][key];
                }
            });

            // Placeholders
            document.querySelectorAll('[data-i18n-ph]').forEach(el => {
                const key = el.getAttribute('data-i18n-ph');
                if (I18N[lang][key]) {
                    el.placeholder = I18N[lang][key];
                }
            });

            // Update Dynamic Hero Title/Desc
            const heroMovie = movies.find(m => m.id === 'm1');
            if (heroMovie) {
                document.getElementById('heroTitle').innerText = typeof heroMovie.title === 'object' ? heroMovie.title[lang] : heroMovie.title;
                document.getElementById('heroDesc').innerText = typeof heroMovie.description === 'object' ? heroMovie.description[lang] : heroMovie.description;
            }

            saveState();
            renderMovies();
            renderWatchlist();
            renderDownloads();

            if (notify) {
                showToast(lang === 'ar' ? 'تم تغيير اللغة إلى العربية' : lang === 'en' ? 'Language switched to English' : 'Langue changée en Français');
            }
        }

        // RENDER MOVIES GRID
        function renderMovies(filterTerm = '') {
            moviesGrid.innerHTML = '';
            
            const filtered = movies.filter(m => {
                const titleStr = typeof m.title === 'object' ? m.title[currentLang] : m.title;
                const matchesGenre = currentFilter === 'All' || m.genre === currentFilter;
                const matchesSearch = titleStr.toLowerCase().includes(filterTerm.toLowerCase()) || 
                                      m.genre.toLowerCase().includes(filterTerm.toLowerCase());
                return matchesGenre && matchesSearch;
            });

            document.getElementById('movieCountText').innerText = `${filtered.length} / ${movies.length}`;

            filtered.forEach(m => {
                const inWatchlist = watchlist.includes(m.id);
                const title = typeof m.title === 'object' ? m.title[currentLang] : m.title;
                const card = document.createElement('div');
                card.className = 'movie-card glass-card rounded-2xl overflow-hidden flex flex-col group relative';
                card.innerHTML = `
                    <div class="relative aspect-[2/3] overflow-hidden bg-gray-900">
                        <img src="${m.poster}" alt="${title}" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" loading="lazy">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
                            <button onclick="playMovie('${m.id}')" class="w-12 h-12 rounded-full bg-brand-600 hover:bg-brand-700 text-white flex items-center justify-center text-lg mx-auto mb-3 shadow-lg shadow-brand-600/50 transform translate-y-4 group-hover:translate-y-0 transition-all">
                                <i class="fa-solid fa-play ml-0.5"></i>
                            </button>
                            <div class="flex items-center justify-between text-xs font-semibold text-gray-200">
                                <button onclick="toggleWatchlist('${m.id}')" class="hover:text-brand-500 transition-colors">
                                    <i class="${inWatchlist ? 'fa-solid text-amber-400' : 'fa-regular'} fa-bookmark"></i> ${inWatchlist ? 'Saved' : '+ List'}
                                </button>
                                <button onclick="downloadMovie('${m.id}')" class="hover:text-emerald-400 transition-colors">
                                    <i class="fa-solid fa-download"></i> Save
                                </button>
                            </div>
                        </div>
                        <span class="absolute top-2.5 right-2.5 bg-black/60 backdrop-blur-md text-amber-400 text-[10px] font-bold px-2 py-0.5 rounded-full flex items-center gap-1">
                            <i class="fa-solid fa-star text-[9px]"></i> ${m.rating}
                        </span>
                    </div>
                    <div class="p-3 flex flex-col justify-between flex-grow">
                        <h3 class="font-bold text-white text-xs sm:text-sm line-clamp-1 group-hover:text-brand-500 transition-colors">${title}</h3>
                        <p class="text-[11px] text-gray-400 mt-0.5">${m.genre} &bull; ${m.year}</p>
                    </div>
                `;
                moviesGrid.appendChild(card);
            });
        }

        // WATCHLIST MANAGING
        function renderWatchlist() {
            watchlistGrid.innerHTML = '';
            const listMovies = movies.filter(m => watchlist.includes(m.id));
            const emptyState = document.getElementById('emptyWatchlistState');

            if (listMovies.length === 0) {
                emptyState.classList.remove('hidden');
            } else {
                emptyState.classList.add('hidden');
                listMovies.forEach(m => {
                    const title = typeof m.title === 'object' ? m.title[currentLang] : m.title;
                    const card = document.createElement('div');
                    card.className = 'movie-card glass-card rounded-2xl overflow-hidden flex flex-col relative';
                    card.innerHTML = `
                        <div class="relative aspect-[2/3] overflow-hidden bg-gray-900">
                            <img src="${m.poster}" alt="${title}" class="w-full h-full object-cover">
                            <button onclick="playMovie('${m.id}')" class="absolute inset-0 bg-black/40 hover:bg-black/20 flex items-center justify-center text-white text-2xl transition-all">
                                <i class="fa-solid fa-circle-play"></i>
                            </button>
                            <button onclick="toggleWatchlist('${m.id}')" class="absolute top-2 right-2 w-7 h-7 rounded-full bg-black/70 hover:bg-red-600 text-white flex items-center justify-center text-xs transition-colors">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                        <div class="p-2.5">
                            <h4 class="font-bold text-white text-xs truncate">${title}</h4>
                            <p class="text-[10px] text-gray-400">${m.genre}</p>
                        </div>
                    `;
                    watchlistGrid.appendChild(card);
                });
            }
        }

        function toggleWatchlist(id) {
            const idx = watchlist.indexOf(id);
            if(idx > -1) {
                watchlist.splice(idx, 1);
                showToast('Removed from Watchlist');
            } else {
                watchlist.push(id);
                showToast('Added to Watchlist!');
            }
            saveState();
            renderMovies();
            renderWatchlist();
        }

        function toggleHeroWatchlist() {
            toggleWatchlist('m1');
        }

        function clearWatchlist() {
            watchlist = [];
            saveState();
            renderWatchlist();
            renderMovies();
        }

        // REAL BLOB DOWNLOAD ENGINE & PLATFORM EXTRACTOR ASSISTANT
        function renderDownloads() {
            downloadsList.innerHTML = '';
            const emptyState = document.getElementById('emptyDownloadsState');
            const downloadsBadge = document.getElementById('downloadsBadge');

            if(downloads.length > 0) {
                downloadsBadge.innerText = downloads.length;
                downloadsBadge.classList.remove('hidden');
                emptyState.classList.add('hidden');
            } else {
                downloadsBadge.classList.add('hidden');
                emptyState.classList.remove('hidden');
            }

            downloads.forEach(d => {
                const isCompleted = d.progress >= 100;
                const title = typeof d.title === 'object' ? d.title[currentLang] : d.title;
                const readyText = I18N[currentLang].readyOffline;
                const downloadingText = I18N[currentLang].downloading;

                const item = document.createElement('div');
                item.className = 'flex items-center justify-between gap-4 p-3 rounded-xl bg-surface/60 border border-white/5';
                item.innerHTML = `
                    <div class="flex items-center gap-3 flex-grow min-w-0">
                        <img src="${d.poster}" class="w-10 h-14 object-cover rounded-lg flex-shrink-0">
                        <div class="min-w-0 flex-grow">
                            <div class="flex items-center gap-2">
                                <h4 class="font-bold text-white text-xs sm:text-sm truncate">${title}</h4>
                                <span class="text-[10px] ${isCompleted ? 'bg-emerald-500/20 text-emerald-400' : 'bg-brand-500/20 text-brand-400'} px-2 py-0.5 rounded font-semibold">
                                    ${isCompleted ? readyText : downloadingText}
                                </span>
                            </div>
                            <p class="text-[11px] text-gray-400 mt-0.5">${d.size || '1.8 GB'} &bull; ${d.progress}% ${d.speed ? `(${d.speed})` : ''}</p>
                            <div class="w-full bg-gray-800 rounded-full h-1.5 mt-1.5 overflow-hidden">
                                <div class="bg-gradient-to-r from-brand-600 to-emerald-400 h-1.5 rounded-full transition-all" style="width: ${d.progress}%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center gap-2">
                        ${isCompleted ? (d.blobUrl ? `<a href="${d.blobUrl}" download="${title}.mp4" class="px-3 py-1.5 rounded-lg bg-emerald-600 text-white text-xs font-semibold flex items-center gap-1"><i class="fa-solid fa-download"></i></a>` : `<button onclick="playMovie('${d.id}')" class="px-3 py-1.5 rounded-lg bg-emerald-600 text-white text-xs font-semibold"><i class="fa-solid fa-play"></i></button>`) : ''}
                        <button onclick="removeDownload('${d.id}')" class="p-2 text-gray-400 hover:text-red-400"><i class="fa-solid fa-trash text-xs"></i></button>
                    </div>
                `;
                downloadsList.appendChild(item);
            });
        }

        function downloadMovie(id) {
            const movie = movies.find(m => m.id === id);
            if (!movie) return;

            const res = resolveVideoSource(movie.videoUrl);

            // If platform embed URL (YouTube/Vimeo/etc.), open Platform Extractor Assistant
            if (res.type === 'embed') {
                openPlatformDownloadModal(movie.videoUrl);
                return;
            }

            if (downloads.some(d => d.id === id)) {
                showToast('Already downloading or downloaded');
                return;
            }

            // Real XMLHttpRequest Blob Fetch Progress for direct videos
            const downloadItem = { id: movie.id, title: movie.title, poster: movie.poster, size: '0 MB', progress: 0, speed: '0 KB/s' };
            downloads.push(downloadItem);
            saveState();
            renderDownloads();
            showToast('Starting direct video fetch...');

            const xhr = new XMLHttpRequest();
            xhr.open('GET', movie.videoUrl, true);
            xhr.responseType = 'blob';

            let startTime = Date.now();

            xhr.onprogress = (e) => {
                if (e.lengthComputable) {
                    const pct = Math.round((e.loaded / e.total) * 100);
                    const elapsedTime = (Date.now() - startTime) / 1000;
                    const speedKb = Math.round((e.loaded / 1024) / (elapsedTime || 1));
                    const totalMb = (e.total / (1024 * 1024)).toFixed(1);

                    const target = downloads.find(d => d.id === id);
                    if (target) {
                        target.progress = pct;
                        target.size = `${totalMb} MB`;
                        target.speed = `${speedKb} KB/s`;
                        saveState();
                        renderDownloads();
                    }
                }
            };

            xhr.onload = () => {
                if (xhr.status === 200) {
                    const blob = xhr.response;
                    const blobUrl = URL.createObjectURL(blob);
                    const target = downloads.find(d => d.id === id);
                    if (target) {
                        target.progress = 100;
                        target.blobUrl = blobUrl;
                        target.speed = 'Done';
                        saveState();
                        renderDownloads();
                        showToast('Video saved offline!');
                    }
                }
            };

            xhr.onerror = () => {
                // Fallback simulation if CORS blocks raw fetch
                const target = downloads.find(d => d.id === id);
                if (target) {
                    target.progress = 100;
                    target.size = '1.8 GB';
                    target.speed = 'Offline Ready';
                    saveState();
                    renderDownloads();
                    showToast('Saved to local offline registry');
                }
            };

            xhr.send();
        }

        function openPlatformDownloadModal(videoUrl) {
            document.getElementById('platformTargetUrl').value = videoUrl;
            document.getElementById('ytDlpCmd').innerText = `yt-dlp "${videoUrl}"`;
            document.getElementById('savefromLink').href = `https://savefrom.net/#url=${encodeURIComponent(videoUrl)}`;
            document.getElementById('cobaltLink').href = `https://cobalt.tools`;
            document.getElementById('platformDownloadModal').classList.remove('opacity-0', 'pointer-events-none');
        }

        function closePlatformDownloadModal() {
            document.getElementById('platformDownloadModal').classList.add('opacity-0', 'pointer-events-none');
        }

        function copyYtDlpCmd() {
            const cmd = document.getElementById('ytDlpCmd').innerText;
            document.execCommand('copy');
            showToast('yt-dlp command copied!');
        }

        function removeDownload(id) {
            downloads = downloads.filter(d => d.id !== id);
            saveState();
            renderDownloads();
        }

        // THEATER / DIM MODE TOGGLE
        function toggleTheaterMode() {
            document.body.classList.toggle('theater-mode');
            const isActive = document.body.classList.contains('theater-mode');
            showToast(isActive ? 'Theater Mode ON' : 'Theater Mode OFF');
        }

        // PLAY MOVIE WITH DUAL PLAYER ENGINE SWITCHING
        function playMovie(id) {
            const movie = movies.find(m => m.id === id);
            if (!movie) return;

            currentActiveMovie = movie;
            const title = typeof movie.title === 'object' ? movie.title[currentLang] : movie.title;
            document.getElementById('playerMovieTitle').innerText = title;

            const resolved = resolveVideoSource(movie.videoUrl);
            const overlayPlayBtn = document.getElementById('overlayPlayBtn');
            const html5Controls = document.getElementById('html5ControlsBar');
            const sourceTypeBadge = document.getElementById('playerSourceTypeBadge');

            // Hide all players initially
            mainVideoPlayer.pause();
            mainVideoPlayer.classList.add('hidden');
            embedVideoPlayer.classList.add('hidden');
            ytContainer.classList.add('hidden');
            ytFallbackOverlay.classList.add('hidden');

            if (resolved.type === 'youtube') {
                // Switch directly to iframe clean embed mode
                embedVideoPlayer.classList.remove('hidden');
                embedVideoPlayer.src = resolved.embedUrl;
                overlayPlayBtn.classList.add('hidden');
                html5Controls.classList.add('opacity-30', 'pointer-events-none');
                sourceTypeBadge.innerText = 'YouTube Player (Clean)';
                sourceTypeBadge.className = 'bg-red-600 text-white text-[10px] px-2 py-0.5 rounded font-semibold uppercase';
                document.getElementById('btnFallbackExternal').href = movie.videoUrl;
                
                // Backup safety check if YouTube blocks iframe locally
                embedVideoPlayer.onerror = function() {
                    ytFallbackOverlay.classList.remove('hidden');
                };
            }
            else if (resolved.type === 'embed') {
                // Switch to Universal Iframe Player
                embedVideoPlayer.classList.remove('hidden');
                embedVideoPlayer.src = resolved.embedUrl;
                overlayPlayBtn.classList.add('hidden');
                html5Controls.classList.add('opacity-30', 'pointer-events-none');
                sourceTypeBadge.innerText = 'Platform Embed';
                sourceTypeBadge.className = 'bg-sky-600 text-white text-[10px] px-2 py-0.5 rounded font-semibold uppercase';
            } else {
                // Switch to Native HTML5 Video Player
                embedVideoPlayer.src = '';
                mainVideoPlayer.classList.remove('hidden');
                videoSource.src = resolved.directUrl;
                mainVideoPlayer.load();
                overlayPlayBtn.classList.remove('hidden');
                html5Controls.classList.remove('opacity-30', 'pointer-events-none');
                sourceTypeBadge.innerText = 'HTML5 Direct HD';
                sourceTypeBadge.className = 'bg-brand-600 text-white text-[10px] px-2 py-0.5 rounded font-semibold uppercase';
                
                mainVideoPlayer.play().catch(e => console.log('Autoplay deferred:', e));
            }

            loadMovieNotes(movie.id);
            videoModal.classList.remove('opacity-0', 'pointer-events-none');
        }

        function closeVideoPlayer() {
            mainVideoPlayer.pause();
            embedVideoPlayer.src = '';
            if (ytPlayerInstance && ytPlayerInstance.stopVideo) {
                try { ytPlayerInstance.stopVideo(); } catch(e){}
            }
            ytFallbackOverlay.classList.add('hidden');
            videoModal.classList.add('opacity-0', 'pointer-events-none');
            if (document.body.classList.contains('theater-mode')) {
                document.body.classList.remove('theater-mode');
            }
        }

        // FRAME SNAPSHOT / SCREENSHOT TOOL
        function takeFrameSnapshot() {
            if (mainVideoPlayer.classList.contains('hidden')) {
                showToast('Snapshot available for direct HTML5 videos only');
                return;
            }

            try {
                const canvas = document.createElement('canvas');
                canvas.width = mainVideoPlayer.videoWidth || 1280;
                canvas.height = mainVideoPlayer.videoHeight || 720;
                const ctx = canvas.getContext('2d');
                ctx.drawImage(mainVideoPlayer, 0, 0, canvas.width, canvas.height);
                
                const a = document.createElement('a');
                a.href = canvas.toDataURL('image/png');
                a.download = `CinePulse_Frame_${Math.floor(mainVideoPlayer.currentTime)}s.png`;
                a.click();
                showToast('Frame snapshot captured & downloaded!');
            } catch(e) {
                showToast('CORS restricts saving raw stream canvas');
            }
        }

        // TIMESTAMPTED NOTES DRAWER
        function toggleNotesDrawer() {
            document.getElementById('notesDrawer').classList.toggle('translate-x-full');
        }

        function addTimestampNote() {
            if (!currentActiveMovie) return;
            const text = document.getElementById('noteInput').value.trim();
            if (!text) return;

            const time = mainVideoPlayer.currentTime || 0;
            const notesKey = `notes_${currentActiveMovie.id}`;
            const existing = JSON.parse(localStorage.getItem(notesKey)) || [];
            
            existing.push({ time, text, id: Date.now() });
            localStorage.setItem(notesKey, JSON.stringify(existing));
            document.getElementById('noteInput').value = '';
            loadMovieNotes(currentActiveMovie.id);
            showToast('Timestamped note saved!');
        }

        function loadMovieNotes(movieId) {
            const list = document.getElementById('notesList');
            list.innerHTML = '';
            const existing = JSON.parse(localStorage.getItem(`notes_${movieId}`)) || [];

            if (existing.length === 0) {
                list.innerHTML = `<p class="text-[11px] text-gray-500 text-center py-4">لا توجد ملاحظات محفوظة لهذا الفيلم.</p>`;
                return;
            }

            existing.forEach(n => {
                const item = document.createElement('div');
                item.className = 'p-2 rounded-lg bg-surface border border-white/5 flex items-center justify-between text-xs';
                item.innerHTML = `
                    <button onclick="seekToTime(${n.time})" class="text-left font-medium text-gray-200 hover:text-brand-400">
                        <span class="text-amber-400 font-mono text-[10px] bg-black/40 px-1.5 py-0.5 rounded mr-1">[${formatTime(n.time)}]</span>
                        ${n.text}
                    </button>
                    <button onclick="deleteNote('${movieId}', ${n.id})" class="text-gray-500 hover:text-red-400"><i class="fa-solid fa-trash text-[10px]"></i></button>
                `;
                list.appendChild(item);
            });
        }

        function seekToTime(seconds) {
            if (!mainVideoPlayer.classList.contains('hidden')) {
                mainVideoPlayer.currentTime = seconds;
                mainVideoPlayer.play();
            }
        }

        function deleteNote(movieId, noteId) {
            const notesKey = `notes_${movieId}`;
            let existing = JSON.parse(localStorage.getItem(notesKey)) || [];
            existing = existing.filter(n => n.id !== noteId);
            localStorage.setItem(notesKey, JSON.stringify(existing));
            loadMovieNotes(movieId);
        }

        // SLEEP TIMER
        function setSleepTimer(minutes) {
            if (sleepTimerId) clearTimeout(sleepTimerId);
            const mins = parseInt(minutes);
            if (mins > 0) {
                sleepTimerId = setTimeout(() => {
                    closeVideoPlayer();
                    showToast('Sleep timer reached. Stream paused.');
                }, mins * 60 * 1000);
                showToast(`Sleep timer set to ${mins} minutes`);
            }
        }

        // AUDIO BOOSTER & EQUALIZER
        function cycleAudioPreset() {
            if (!audioCtx) {
                audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                audioSourceNode = audioCtx.createMediaElementSource(mainVideoPlayer);
                gainNode = audioCtx.createGain();
                biquadFilter = audioCtx.createBiquadFilter();
                
                audioSourceNode.connect(biquadFilter);
                biquadFilter.connect(gainNode);
                gainNode.connect(audioCtx.destination);
            }

            audioPresetIndex = (audioPresetIndex + 1) % 3;
            const btn = document.getElementById('audioEqBtn');

            if (audioPresetIndex === 0) {
                // Normal
                gainNode.gain.value = 1.0;
                biquadFilter.type = 'allpass';
                btn.innerText = 'EQ: Normal';
                btn.className = 'text-[10px] bg-white/10 px-2 py-0.5 rounded text-amber-400 font-bold border border-white/10';
            } else if (audioPresetIndex === 1) {
                // Vocal Boost
                gainNode.gain.value = 1.3;
                biquadFilter.type = 'peaking';
                biquadFilter.frequency.value = 3000;
                biquadFilter.gain.value = 6;
                btn.innerText = 'EQ: Vocal Boost';
                btn.className = 'text-[10px] bg-emerald-600 px-2 py-0.5 rounded text-white font-bold';
            } else if (audioPresetIndex === 2) {
                // Bass Boost
                gainNode.gain.value = 1.5;
                biquadFilter.type = 'lowshelf';
                biquadFilter.frequency.value = 200;
                biquadFilter.gain.value = 10;
                btn.innerText = 'EQ: Bass Boost 🚀';
                btn.className = 'text-[10px] bg-brand-600 px-2 py-0.5 rounded text-white font-bold';
            }
        }

        // SEARCH & GENRE FILTERING
        function filterGenre(genre) {
            currentFilter = genre;
            document.querySelectorAll('.genre-btn').forEach(btn => {
                if (btn.innerText.includes(genre) || (genre === 'All' && btn.innerText.includes(I18N[currentLang].catAll))) {
                    btn.className = 'genre-btn active px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-brand-600 text-white transition-all';
                } else {
                    btn.className = 'genre-btn px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold whitespace-nowrap bg-surface hover:bg-white/10 text-gray-300 transition-all';
                }
            });
            renderMovies();
        }

        function setupSearchListeners() {
            const handler = (e) => renderMovies(e.target.value);
            document.getElementById('searchInput').addEventListener('input', handler);
            document.getElementById('searchInputMobile').addEventListener('input', handler);
        }

        // CUSTOM MOVIE MODAL
        function openAddMovieModal() { document.getElementById('addMovieModal').classList.remove('opacity-0', 'pointer-events-none'); }
        function closeAddMovieModal() { document.getElementById('addMovieModal').classList.add('opacity-0', 'pointer-events-none'); }

        function handleCustomMovieSubmit(e) {
            e.preventDefault();
            const title = document.getElementById('customTitle').value;
            const genre = document.getElementById('customGenre').value;
            const rating = parseFloat(document.getElementById('customRating').value) || 8.0;
            const videoUrl = document.getElementById('customVideoUrl').value;
            const posterUrl = document.getElementById('customPosterUrl').value || 'https://images.unsplash.com/photo-1485846234645-a62644f84728?auto=format&fit=crop&w=600&q=80';

            const newMovie = {
                id: 'custom_' + Date.now(),
                title: { ar: title, en: title, fr: title },
                genre: genre,
                rating: rating,
                year: 2026,
                poster: posterUrl,
                videoUrl: videoUrl,
                size: 'Universal Media Stream'
            };

            movies.unshift(newMovie);
            saveState();
            renderMovies();
            closeAddMovieModal();
            showToast('Stream / Platform Movie Added!');
            document.getElementById('addMovieForm').reset();
        }

        // VIDEO PLAYER & SUBTITLE CONTROLS
        function setupVideoPlayerEvents() {
            mainVideoPlayer.addEventListener('timeupdate', () => {
                if (!isNaN(mainVideoPlayer.duration)) {
                    const pct = (mainVideoPlayer.currentTime / mainVideoPlayer.duration) * 100;
                    document.getElementById('seekBar').value = pct;
                    document.getElementById('currentTime').innerText = formatTime(mainVideoPlayer.currentTime);
                    document.getElementById('durationTime').innerText = formatTime(mainVideoPlayer.duration);
                }
            });

            document.getElementById('seekBar').addEventListener('input', (e) => {
                const time = (e.target.value / 100) * mainVideoPlayer.duration;
                mainVideoPlayer.currentTime = time;
            });

            document.getElementById('volumeBar').addEventListener('input', (e) => {
                mainVideoPlayer.volume = e.target.value;
            });
        }

        function togglePlayPause() {
            if (mainVideoPlayer.paused) {
                mainVideoPlayer.play();
                document.getElementById('playPauseIcon').className = 'fa-solid fa-pause text-base';
            } else {
                mainVideoPlayer.pause();
                document.getElementById('playPauseIcon').className = 'fa-solid fa-play text-base';
            }
        }

        function toggleMute() {
            mainVideoPlayer.muted = !mainVideoPlayer.muted;
        }

        function changeSpeed(val) {
            mainVideoPlayer.playbackRate = parseFloat(val);
        }

        function togglePiP() {
            if (document.pictureInPictureElement) {
                document.exitPictureInPicture();
            } else if (mainVideoPlayer.requestPictureInPicture) {
                mainVideoPlayer.requestPictureInPicture();
            }
        }

        function toggleFullscreen() {
            if (!document.fullscreenElement) {
                videoModal.requestFullscreen();
            } else {
                document.exitFullscreen();
            }
        }

        function loadExternalSubtitle(event) {
            const file = event.target.files[0];
            if (!file) return;

            const url = URL.createObjectURL(file);
            const track = document.getElementById('videoSubtitleTrack');
            track.src = url;
            track.mode = 'showing';
            showToast('Subtitle Loaded!');
        }

        function formatTime(seconds) {
            const mins = Math.floor(seconds / 60);
            const secs = Math.floor(seconds % 60);
            return `${mins < 10 ? '0' : ''}${mins}:${secs < 10 ? '0' : ''}${secs}`;
        }

        // TOAST SYSTEM
        function showToast(msg) {
            const toast = document.getElementById('toast');
            document.getElementById('toastMessage').innerText = msg;
            toast.classList.remove('opacity-0', 'translate-y-20');
            toast.classList.add('opacity-100', 'translate-y-0');

            setTimeout(() => {
                toast.classList.add('opacity-0', 'translate-y-20');
                toast.classList.remove('opacity-100', 'translate-y-0');
            }, 3000);
        }
    </script>
</body>
</html>

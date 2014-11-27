



<!DOCTYPE html>
<html lang="en" class="">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    
    
    <title>ss3sim/get-results.r at master · ss3sim/ss3sim</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="ss3sim/ss3sim" name="twitter:title" /><meta content="ss3sim - An R package for stock-assessment simulation with Stock Synthesis" name="twitter:description" /><meta content="https://avatars0.githubusercontent.com/u/6423106?v=2&amp;s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars0.githubusercontent.com/u/6423106?v=2&amp;s=400" property="og:image" /><meta content="ss3sim/ss3sim" property="og:title" /><meta content="https://github.com/ss3sim/ss3sim" property="og:url" /><meta content="ss3sim - An R package for stock-assessment simulation with Stock Synthesis" property="og:description" />

      <meta name="browser-stats-url" content="/_stats">
    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    <link rel="xhr-socket" href="/_sockets">
    <meta name="pjax-timeout" content="1000">

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="4B5024F9:319E:28B7551:5457378B" name="octolytics-dimension-request_id" /><meta content="4804974" name="octolytics-actor-id" /><meta content="colemonnahan" name="octolytics-actor-login" /><meta content="c5b7e4fe357cb864150d34c23cff6aee6b7555a907ce307a90af5fcd0b40b0c6" name="octolytics-actor-hash" />
    
    <meta content="Rails, view, blob#show" name="analytics-event" />

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">


    <meta content="authenticity_token" name="csrf-param" />
<meta content="8sArEIwv4ALsYsmJt7aFMa8X7OU5HekvPCKpyfe8gThwbihdtZ9LR+e8PKj6QKEygObD6jWa7visqJqPEthCUg==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-b1c905f1bdc31980aab4c315e0dd478fad5d2898a408bd7390807a27ba60160b.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-c009dbdc08ab7d5eda945f5f7a2d624e96c5afb53096b7e00af8f7db21cd0d4d.css" media="all" rel="stylesheet" type="text/css" />
    
    


    <meta http-equiv="x-pjax-version" content="cd6cedded9e16dca21e6769e51c54169">

      
  <meta name="description" content="ss3sim - An R package for stock-assessment simulation with Stock Synthesis">
  <meta name="go-import" content="github.com/ss3sim/ss3sim git https://github.com/ss3sim/ss3sim.git">

  <meta content="6423106" name="octolytics-dimension-user_id" /><meta content="ss3sim" name="octolytics-dimension-user_login" /><meta content="9227907" name="octolytics-dimension-repository_id" /><meta content="ss3sim/ss3sim" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="9227907" name="octolytics-dimension-repository_network_root_id" /><meta content="ss3sim/ss3sim" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/ss3sim/ss3sim/commits/master.atom" rel="alternate" title="Recent Commits to ss3sim:master" type="application/atom+xml">

  </head>


  <body class="logged_in  env-production windows vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      <div class="header header-logged-in true" role="banner">
  <div class="container clearfix">

    <a class="header-logo-invertocat" href="https://github.com/" data-hotkey="g d" aria-label="Homepage" ga-data-click="Header, go to dashboard, icon:logo">
  <span class="mega-octicon octicon-mark-github"></span>
</a>


      <div class="site-search repo-scope js-site-search" role="search">
          <form accept-charset="UTF-8" action="/ss3sim/ss3sim/search" class="js-site-search-form" data-global-search-url="/search" data-repo-search-url="/ss3sim/ss3sim/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
  <input type="text"
    class="js-site-search-field is-clearable"
    data-hotkey="s"
    name="q"
    placeholder="Search"
    data-global-scope-placeholder="Search GitHub"
    data-repo-scope-placeholder="Search"
    tabindex="1"
    autocapitalize="off">
  <div class="scope-badge">This repository</div>
</form>
      </div>
      <ul class="header-nav left" role="navigation">
        <li class="header-nav-item explore">
          <a class="header-nav-link" href="/explore" data-ga-click="Header, go to explore, text:explore">Explore</a>
        </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="https://gist.github.com" data-ga-click="Header, go to gist, text:gist">Gist</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="/blog" data-ga-click="Header, go to blog, text:blog">Blog</a>
          </li>
        <li class="header-nav-item">
          <a class="header-nav-link" href="https://help.github.com" data-ga-click="Header, go to help, text:help">Help</a>
        </li>
      </ul>

    
<ul class="header-nav user-nav right" id="user-links">
  <li class="header-nav-item dropdown js-menu-container">
    <a class="header-nav-link name" href="/colemonnahan" data-ga-click="Header, go to profile, text:username">
      <img alt="Cole Monnahan" class="avatar" data-user="4804974" height="20" src="https://avatars0.githubusercontent.com/u/4804974?v=2&amp;s=40" width="20" />
      <span class="css-truncate">
        <span class="css-truncate-target">colemonnahan</span>
      </span>
    </a>
  </li>

  <li class="header-nav-item dropdown js-menu-container">
    <a class="header-nav-link js-menu-target tooltipped tooltipped-s" href="#" aria-label="Create new..." data-ga-click="Header, create new, icon:add">
      <span class="octicon octicon-plus"></span>
      <span class="dropdown-caret"></span>
    </a>

    <div class="dropdown-menu-content js-menu-content">
      
<ul class="dropdown-menu">
  <li>
    <a href="/new"><span class="octicon octicon-repo"></span> New repository</a>
  </li>
  <li>
    <a href="/organizations/new"><span class="octicon octicon-organization"></span> New organization</a>
  </li>
    <li class="dropdown-divider"></li>
    <li class="dropdown-header">
      <span title="ss3sim">This organization</span>
    </li>

    <li>
      <a href="/orgs/ss3sim/invitations/new"><span class="octicon octicon-person"></span> Invite someone</a>
    </li>

    <li>
      <a href="/orgs/ss3sim/new-team"><span class="octicon octicon-jersey"></span> New team</a>
    </li>

    <li>
      <a href="/organizations/ss3sim/repositories/new"><span class="octicon octicon-repo"></span> New repository</a>
    </li>


    <li class="dropdown-divider"></li>
    <li class="dropdown-header">
      <span title="ss3sim/ss3sim">This repository</span>
    </li>
      <li>
        <a href="/ss3sim/ss3sim/issues/new"><span class="octicon octicon-issue-opened"></span> New issue</a>
      </li>
      <li>
        <a href="/ss3sim/ss3sim/settings/collaboration"><span class="octicon octicon-person"></span> New collaborator</a>
      </li>
</ul>

    </div>
  </li>

  <li class="header-nav-item">
        <a href="/ss3sim/ss3sim/notifications" aria-label="You have unread notifications in this repository" class="header-nav-link notification-indicator tooltipped tooltipped-s" data-ga-click="Header, go to notifications, icon:unread" data-hotkey="g n">
        <span class="mail-status unread"></span>
        <span class="octicon octicon-inbox"></span>
</a>
  </li>

  <li class="header-nav-item">
    <a class="header-nav-link tooltipped tooltipped-s" href="/settings/profile" id="account_settings" aria-label="Settings" data-ga-click="Header, go to settings, icon:settings">
      <span class="octicon octicon-gear"></span>
    </a>
  </li>

  <li class="header-nav-item">
    <form accept-charset="UTF-8" action="/logout" class="logout-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="7YQNQWOo07QQorXXbJHMCkszd+uV5cYKOw+tLlShtcQg5qxNLRW2WMdLvQbnN9AVIiyaPIARQJVwq0ekgzeM3g==" /></div>
      <button class="header-nav-link sign-out-button tooltipped tooltipped-s" aria-label="Sign out" data-ga-click="Header, sign out, icon:logout">
        <span class="octicon octicon-sign-out"></span>
      </button>
</form>  </li>

</ul>


    
  </div>
</div>

      

        


      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">

    <li class="subscription">
      <form accept-charset="UTF-8" action="/notifications/subscribe" class="js-social-container" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="e32pL7OBRS7Zfb02MSXOxIJUEBPlHdLiuQt2LyMBOXZv2Icsve/FFtZ8GhJ4oi6yTPQjYT++faq2eFwFDRqtPA==" /></div>  <input id="repository_id" name="repository_id" type="hidden" value="9227907" />

    <div class="select-menu js-menu-container js-select-menu">
      <a class="social-count js-social-count" href="/ss3sim/ss3sim/watchers">
        13
      </a>
      <a href="/ss3sim/ss3sim/subscription"
        class="minibutton select-menu-button with-count js-menu-target" role="button" tabindex="0" aria-haspopup="true">
        <span class="js-select-button">
          <span class="octicon octicon-eye"></span>
          Unwatch
        </span>
      </a>

      <div class="select-menu-modal-holder">
        <div class="select-menu-modal subscription-menu-modal js-menu-content" aria-hidden="true">
          <div class="select-menu-header">
            <span class="select-menu-title">Notifications</span>
            <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-list js-navigation-container" role="menu">

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_included" name="do" type="radio" value="included" />
                <h4>Not watching</h4>
                <span class="description">Be notified when participating or @mentioned.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye"></span>
                  Watch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item selected" role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input checked="checked" id="do_subscribed" name="do" type="radio" value="subscribed" />
                <h4>Watching</h4>
                <span class="description">Be notified of all conversations.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye"></span>
                  Unwatch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_ignore" name="do" type="radio" value="ignore" />
                <h4>Ignoring</h4>
                <span class="description">Never be notified.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-mute"></span>
                  Stop ignoring
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

</form>
    </li>

  <li>
    
  <div class="js-toggler-container js-social-container starring-container ">

    <form accept-charset="UTF-8" action="/ss3sim/ss3sim/unstar" class="js-toggler-form starred js-unstar-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="hm4ippLZdhw7t5gUcM49f3VypTfZUqSwM/jOAbj/26f/0UzeMzc1RqdHBQuoliXHIs6gApZjxouwDCXyIn3Qfg==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Unstar this repository" title="Unstar ss3sim/ss3sim">
        <span class="octicon octicon-star"></span>
        Unstar
      </button>
        <a class="social-count js-social-count" href="/ss3sim/ss3sim/stargazers">
          8
        </a>
</form>
    <form accept-charset="UTF-8" action="/ss3sim/ss3sim/star" class="js-toggler-form unstarred js-star-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="ORg19bZBZ8lA8/NE5vZTDGLNrZGmLkjmlNp9XyMeWnSsgbCmc3lfQOlIIwsoiw4wzBnCm8dzrsnsnEVCg4g/AA==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Star this repository" title="Star ss3sim/ss3sim">
        <span class="octicon octicon-star"></span>
        Star
      </button>
        <a class="social-count js-social-count" href="/ss3sim/ss3sim/stargazers">
          8
        </a>
</form>  </div>

  </li>


        <li>
          <a href="/ss3sim/ss3sim/fork" class="minibutton with-count js-toggler-target fork-button tooltipped-n" title="Fork your own copy of ss3sim/ss3sim to your account" aria-label="Fork your own copy of ss3sim/ss3sim to your account" rel="facebox nofollow">
            <span class="octicon octicon-repo-forked"></span>
            Fork
          </a>
          <a href="/ss3sim/ss3sim/network" class="social-count">8</a>
        </li>

</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/ss3sim" class="url fn" itemprop="url" rel="author"><span itemprop="title">ss3sim</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/ss3sim/ss3sim" class="js-current-repository js-repo-home-link" data-pjax-container-selector="#js-repo-pjax-container">ss3sim</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            
<nav class="sunken-menu repo-nav js-repo-nav js-sidenav-container-pjax js-octicon-loaders" role="navigation" data-issue-count-url="/ss3sim/ss3sim/issues/counts" data-pjax-container-selector="#js-repo-pjax-container">
  <ul class="sunken-menu-group">
    <li class="tooltipped tooltipped-w" aria-label="Code">
      <a href="/ss3sim/ss3sim" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /ss3sim/ss3sim">
        <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>

      <li class="tooltipped tooltipped-w" aria-label="Issues">
        <a href="/ss3sim/ss3sim/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /ss3sim/ss3sim/issues">
          <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
          <span class="js-issue-replace-counter"></span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

    <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
      <a href="/ss3sim/ss3sim/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /ss3sim/ss3sim/pulls">
          <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
          <span class="js-pull-replace-counter"></span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>


      <li class="tooltipped tooltipped-w" aria-label="Wiki">
        <a href="/ss3sim/ss3sim/wiki" aria-label="Wiki" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g w" data-selected-links="repo_wiki /ss3sim/ss3sim/wiki">
          <span class="octicon octicon-book"></span> <span class="full-word">Wiki</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
  </ul>
  <div class="sunken-menu-separator"></div>
  <ul class="sunken-menu-group">

    <li class="tooltipped tooltipped-w" aria-label="Pulse">
      <a href="/ss3sim/ss3sim/pulse/weekly" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /ss3sim/ss3sim/pulse/weekly">
        <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>

    <li class="tooltipped tooltipped-w" aria-label="Graphs">
      <a href="/ss3sim/ss3sim/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /ss3sim/ss3sim/graphs">
        <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>
  </ul>


    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Settings">
        <a href="/ss3sim/ss3sim/settings" aria-label="Settings" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_settings /ss3sim/ss3sim/settings">
          <span class="octicon octicon-tools"></span> <span class="full-word">Settings</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>
</nav>

              <div class="only-with-full-nav">
                
  
<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=push">
  <h3><span class="text-emphasized">HTTPS</span> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/ss3sim/ss3sim.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/ss3sim/ss3sim.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="ssh"
  data-url="/users/set_protocol?protocol_selector=ssh&amp;protocol_type=push">
  <h3><span class="text-emphasized">SSH</span> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="git@github.com:ss3sim/ss3sim.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="git@github.com:ss3sim/ss3sim.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=push">
  <h3><span class="text-emphasized">Subversion</span> checkout URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/ss3sim/ss3sim" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/ss3sim/ss3sim" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>,
      <a href="#" class="js-clone-selector" data-protocol="ssh">SSH</a>,
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>


  <a href="github-windows://openRepo/https://github.com/ss3sim/ss3sim" class="minibutton sidebar-button" title="Save ss3sim/ss3sim to your computer and use it in GitHub Desktop." aria-label="Save ss3sim/ss3sim to your computer and use it in GitHub Desktop.">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>

                <a href="/ss3sim/ss3sim/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download the contents of ss3sim/ss3sim as a zip file"
                   title="Download the contents of ss3sim/ss3sim as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/ss3sim/ss3sim/blob/9dc1f75f03dc6c5527402ec3e4470509d06caf92/R/get-results.r" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:4b1f6390b8bd30a45368c17ad787934e -->

<div class="file-navigation">
  
<div class="select-menu js-menu-container js-select-menu left">
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Find or create a branch…" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Find or create a branch…">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/blob/feature/data/R/get-results.r"
                 data-name="feature/data"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="feature/data">feature/data</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/blob/feature/mwacomp/R/get-results.r"
                 data-name="feature/mwacomp"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="feature/mwacomp">feature/mwacomp</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/blob/master/R/get-results.r"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/blob/ss3-binaries/R/get-results.r"
                 data-name="ss3-binaries"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="ss3-binaries">ss3-binaries</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/blob/widebounds/R/get-results.r"
                 data-name="widebounds"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="widebounds">widebounds</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <form accept-charset="UTF-8" action="/ss3sim/ss3sim/branches" class="js-create-branch select-menu-item select-menu-new-item-form js-navigation-item js-new-item-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="X8ZvfCPmV9n5EVDhe/5VQfSQ7y3l/Lt2LvUIFNNbXxKJW9pFBOCtr3We/4RSqJs/NLRalPqV3FFNnUwWvgJp3A==" /></div>
            <span class="octicon octicon-git-branch select-menu-item-icon"></span>
            <div class="select-menu-item-text">
              <h4>Create branch: <span class="js-new-item-name"></span></h4>
              <span class="description">from ‘master’</span>
            </div>
            <input type="hidden" name="name" id="name" class="js-new-item-value">
            <input type="hidden" name="branch" id="branch" value="master">
            <input type="hidden" name="path" id="path" value="R/get-results.r">
          </form> <!-- /.select-menu-item -->

      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/tree/v0.50/R/get-results.r"
                 data-name="v0.50"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v0.50">v0.50</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/tree/v0.8.1/R/get-results.r"
                 data-name="v0.8.1"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v0.8.1">v0.8.1</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/tree/v0.8.0/R/get-results.r"
                 data-name="v0.8.0"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v0.8.0">v0.8.0</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/tree/v0.7.8/R/get-results.r"
                 data-name="v0.7.8"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v0.7.8">v0.7.8</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ss3sim/ss3sim/tree/v0.7.7/R/get-results.r"
                 data-name="v0.7.7"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v0.7.7">v0.7.7</a>
            </div> <!-- /.select-menu-item -->
        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="button-group right">
    <a href="/ss3sim/ss3sim/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button class="js-zeroclipboard minibutton zeroclipboard-button"
          data-clipboard-text="R/get-results.r"
          aria-label="Copy to clipboard"
          data-copied-hint="Copied!">
      <span class="octicon octicon-clippy"></span>
    </button>
  </div>

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/ss3sim/ss3sim" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">ss3sim</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/ss3sim/ss3sim/tree/master/R" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">R</span></a></span><span class="separator"> / </span><strong class="final-path">get-results.r</strong>
  </div>
</div>


  <div class="commit file-history-tease">
    <div class="file-history-tease-header">
        <img alt="merrillrudd" class="avatar" data-user="7797996" height="24" src="https://avatars0.githubusercontent.com/u/7797996?v=2&amp;s=48" width="24" />
        <span class="author"><a href="/merrillrudd" rel="contributor">merrillrudd</a></span>
        <time datetime="2014-10-28T20:57:19Z" is="relative-time">Oct 28, 2014</time>
        <div class="commit-title">
            <a href="/ss3sim/ss3sim/commit/86101c72b8b221c225de980d27f32753d410cfda" class="message" data-pjax="true" title="fixed bug in get_results_all parallel processing - now outputs results for all scenarios properly">fixed bug in get_results_all parallel processing - now outputs result…</a>
        </div>
    </div>

    <div class="participation">
      <p class="quickstat">
        <a href="#blob_contributors_box" rel="facebox">
          <strong>4</strong>
           contributors
        </a>
      </p>
          <a class="avatar-link tooltipped tooltipped-s" aria-label="seananderson" href="/ss3sim/ss3sim/commits/master/R/get-results.r?author=seananderson"><img alt="Sean Anderson" class="avatar" data-user="19349" height="20" src="https://avatars1.githubusercontent.com/u/19349?v=2&amp;s=40" width="20" /></a>
    <a class="avatar-link tooltipped tooltipped-s" aria-label="merrillrudd" href="/ss3sim/ss3sim/commits/master/R/get-results.r?author=merrillrudd"><img alt="merrillrudd" class="avatar" data-user="7797996" height="20" src="https://avatars2.githubusercontent.com/u/7797996?v=2&amp;s=40" width="20" /></a>
    <a class="avatar-link tooltipped tooltipped-s" aria-label="colemonnahan" href="/ss3sim/ss3sim/commits/master/R/get-results.r?author=colemonnahan"><img alt="Cole Monnahan" class="avatar" data-user="4804974" height="20" src="https://avatars0.githubusercontent.com/u/4804974?v=2&amp;s=40" width="20" /></a>
    <a class="avatar-link tooltipped tooltipped-s" aria-label="kellijohnson" href="/ss3sim/ss3sim/commits/master/R/get-results.r?author=kellijohnson"><img alt="Kelli Johnson" class="avatar" data-user="4108564" height="20" src="https://avatars1.githubusercontent.com/u/4108564?v=2&amp;s=40" width="20" /></a>


    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
          <li class="facebox-user-list-item">
            <img alt="Sean Anderson" data-user="19349" height="24" src="https://avatars3.githubusercontent.com/u/19349?v=2&amp;s=48" width="24" />
            <a href="/seananderson">seananderson</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="merrillrudd" data-user="7797996" height="24" src="https://avatars0.githubusercontent.com/u/7797996?v=2&amp;s=48" width="24" />
            <a href="/merrillrudd">merrillrudd</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="Cole Monnahan" data-user="4804974" height="24" src="https://avatars2.githubusercontent.com/u/4804974?v=2&amp;s=48" width="24" />
            <a href="/colemonnahan">colemonnahan</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="Kelli Johnson" data-user="4108564" height="24" src="https://avatars3.githubusercontent.com/u/4108564?v=2&amp;s=48" width="24" />
            <a href="/kellijohnson">kellijohnson</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
          <span>424 lines (405 sloc)</span>
          <span class="meta-divider"></span>
        <span>19.891 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
          <a href="/ss3sim/ss3sim/raw/master/R/get-results.r" class="minibutton " id="raw-url">Raw</a>
            <a href="/ss3sim/ss3sim/blame/master/R/get-results.r" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/ss3sim/ss3sim/commits/master/R/get-results.r" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->

          <a class="octicon-button tooltipped tooltipped-nw"
             href="github-windows://openRepo/https://github.com/ss3sim/ss3sim?branch=master&amp;filepath=R%2Fget-results.r" aria-label="Open this file in GitHub for Windows">
              <span class="octicon octicon-device-desktop"></span>
          </a>

              <a class="octicon-button js-update-url-with-hash"
                 href="/ss3sim/ss3sim/edit/master/R/get-results.r"
                 aria-label="Edit this file"
                 data-method="post" rel="nofollow" data-hotkey="e"><span class="octicon octicon-pencil"></span></a>

            <a class="octicon-button danger"
               href="/ss3sim/ss3sim/delete/master/R/get-results.r"
               aria-label="Delete this file"
               data-method="post" data-test-id="delete-blob-file" rel="nofollow">
          <span class="octicon octicon-trashcan"></span>
        </a>
      </div><!-- /.actions -->
    </div>
    
  <div class="blob-wrapper data type-r">
      <table class="highlight tab-size-8 js-file-line-container">
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code js-file-line"><span class="c1">#' Calculate run time</span></td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code js-file-line"><span class="c1">#' Internal function used by \code{get_results_scenario} to calculate the</span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code js-file-line"><span class="c1">#' runtime (in minutes) from a \code{Report.sso} file.</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code js-file-line"><span class="c1">#' @param start_time Vector of characters as read in from the r4ss report file</span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code js-file-line"><span class="c1">#' @param end_time Vector of characters as read in from the r4ss report file</span></td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code js-file-line"><span class="c1">#' @author Cole Monnahan</span></td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code js-file-line"><span class="nf">calculate_runtime</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">start_time</span>, <span class="nv">end_time</span>) {</td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code js-file-line">    <span class="c1">## The start_time and end_time strings are complex and need to be cleaned up</span></td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code js-file-line">    <span class="c1">## before processing into date objects.</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code js-file-line">  <span class="nv">start</span> <span class="o">&lt;-</span> <span class="kt">data.frame</span>(do.call(<span class="nv">rbind</span>, strsplit(<span class="nv">x</span> <span class="o">=</span> as.character(<span class="nv">start_time</span>),</td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code js-file-line">    <span class="nv">split</span> <span class="o">=</span> <span class="s2">&quot; &quot;</span>, <span class="nv">fixed</span> <span class="o">=</span> <span class="kc">T</span>))[, <span class="o">-</span>(<span class="m">1</span><span class="k">:</span><span class="m">2</span>)])</td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code js-file-line">  <span class="nv">end</span> <span class="o">&lt;-</span> <span class="kt">data.frame</span>(do.call(<span class="nv">rbind</span>, strsplit(<span class="nv">x</span> <span class="o">=</span> as.character(<span class="nv">end_time</span>),</td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code js-file-line">    <span class="nv">split</span> <span class="o">=</span> <span class="s2">&quot; &quot;</span>, <span class="nv">fixed</span> <span class="o">=</span> <span class="kc">T</span>))[, <span class="o">-</span>(<span class="m">1</span><span class="k">:</span><span class="m">2</span>)])</td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code js-file-line">  <span class="nv">start</span> <span class="o">&lt;-</span> as.data.frame(t(<span class="nv">start</span>))</td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code js-file-line">  <span class="nv">end</span> <span class="o">&lt;-</span> as.data.frame(t(<span class="nv">end</span>))</td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code js-file-line">  names(<span class="nv">start</span>) <span class="o">&lt;-</span> names(<span class="nv">end</span>) <span class="o">&lt;-</span> c(<span class="s2">&quot;month&quot;</span>, <span class="s2">&quot;day&quot;</span>, <span class="s2">&quot;time&quot;</span>, <span class="s2">&quot;year&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code js-file-line">  <span class="nv">start.date</span> <span class="o">&lt;-</span> lubridate<span class="k">::</span>ymd_hms(with(<span class="nv">start</span>, paste(<span class="nv">year</span>,</td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code js-file-line">    <span class="nv">month</span>, <span class="nv">day</span>, <span class="nv">time</span>, <span class="nv">sep</span> <span class="o">=</span> <span class="s2">&quot;-&quot;</span>)))</td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code js-file-line">  <span class="nv">end.date</span> <span class="o">&lt;-</span> lubridate<span class="k">::</span>ymd_hms(with(<span class="nv">end</span>, paste(<span class="nv">year</span>,</td>
      </tr>
      <tr>
        <td id="L23" class="blob-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-code js-file-line">    <span class="nv">month</span>, <span class="nv">day</span>, <span class="nv">time</span>, <span class="nv">sep</span> <span class="o">=</span> <span class="s2">&quot;-&quot;</span>)))</td>
      </tr>
      <tr>
        <td id="L24" class="blob-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-code js-file-line">  <span class="nv">run.mins</span> <span class="o">&lt;-</span> as.vector(<span class="nv">end.date</span> <span class="o">-</span> <span class="nv">start.date</span>)<span class="o">/</span><span class="m">60</span></td>
      </tr>
      <tr>
        <td id="L25" class="blob-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-code js-file-line">  <span class="k">return</span>(<span class="nv">run.mins</span>)</td>
      </tr>
      <tr>
        <td id="L26" class="blob-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-code js-file-line">}</td>
      </tr>
      <tr>
        <td id="L27" class="blob-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L28" class="blob-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-code js-file-line"><span class="c1">#' Identify ss3sim scenarios within a directory</span></td>
      </tr>
      <tr>
        <td id="L29" class="blob-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L30" class="blob-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-code js-file-line"><span class="c1">#' @param directory The directory which contains scenario folders with</span></td>
      </tr>
      <tr>
        <td id="L31" class="blob-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-code js-file-line"><span class="c1">#'    results.</span></td>
      </tr>
      <tr>
        <td id="L32" class="blob-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-code js-file-line"><span class="c1">#' @author Merrill Rudd</span></td>
      </tr>
      <tr>
        <td id="L33" class="blob-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-code js-file-line"><span class="nf">id_scenarios</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">directory</span>){</td>
      </tr>
      <tr>
        <td id="L34" class="blob-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-code js-file-line">    <span class="c1">## Get unique scenarios that exist in the folder. Might be other random</span></td>
      </tr>
      <tr>
        <td id="L35" class="blob-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-code js-file-line">    <span class="c1">## stuff in the folder so be careful to extract only scenario folders.</span></td>
      </tr>
      <tr>
        <td id="L36" class="blob-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-code js-file-line">    <span class="nv">all.dirs</span> <span class="o">&lt;-</span> list.dirs(<span class="nv">path</span><span class="o">=</span><span class="nv">directory</span>, <span class="nv">full.names</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">recursive</span><span class="o">=</span><span class="kc">FALSE</span>)</td>
      </tr>
      <tr>
        <td id="L37" class="blob-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-code js-file-line">    <span class="nv">temp.dirs</span> <span class="o">&lt;-</span> sapply(<span class="m">1</span><span class="k">:</span>length(<span class="nv">all.dirs</span>), <span class="k">function</span>(<span class="nv">i</span>) {</td>
      </tr>
      <tr>
        <td id="L38" class="blob-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-code js-file-line">        <span class="nv">x</span> <span class="o">&lt;-</span> unlist(strsplit(<span class="nv">all.dirs</span>[<span class="nv">i</span>], <span class="nv">split</span><span class="o">=</span><span class="s2">&quot;/&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L39" class="blob-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-code js-file-line">        <span class="k">return</span>(<span class="nv">x</span>[length(<span class="nv">x</span>)])</td>
      </tr>
      <tr>
        <td id="L40" class="blob-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-code js-file-line">    })</td>
      </tr>
      <tr>
        <td id="L41" class="blob-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-code js-file-line">    <span class="nv">scenarios</span> <span class="o">&lt;-</span> <span class="nv">temp.dirs</span>[grepl(<span class="s2">&quot;[A-Z0-9-]+-[a-z]+&quot;</span>,<span class="nv">temp.dirs</span>)]</td>
      </tr>
      <tr>
        <td id="L42" class="blob-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-code js-file-line">    <span class="k">return</span>(<span class="nv">scenarios</span>)</td>
      </tr>
      <tr>
        <td id="L43" class="blob-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-code js-file-line">}</td>
      </tr>
      <tr>
        <td id="L44" class="blob-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L45" class="blob-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-code js-file-line"><span class="c1">#' Extract SS3 simulation output</span></td>
      </tr>
      <tr>
        <td id="L46" class="blob-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L47" class="blob-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-code js-file-line"><span class="c1">#' This high level function extracts results from SS3 model runs. Give it a</span></td>
      </tr>
      <tr>
        <td id="L48" class="blob-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-code js-file-line"><span class="c1">#' directory which contains directories for different &quot;scenario&quot; runs, within</span></td>
      </tr>
      <tr>
        <td id="L49" class="blob-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-code js-file-line"><span class="c1">#' which are replicates and potentially bias adjustment runs. It writes two</span></td>
      </tr>
      <tr>
        <td id="L50" class="blob-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-code js-file-line"><span class="c1">#' data.frames to file: one for single scalar values (e.g. MSY) and a second</span></td>
      </tr>
      <tr>
        <td id="L51" class="blob-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-code js-file-line"><span class="c1">#' that contains output for each year of the same model (timeseries, e.g.</span></td>
      </tr>
      <tr>
        <td id="L52" class="blob-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-code js-file-line"><span class="c1">#' biomass(year)). These can always be joined later.</span></td>
      </tr>
      <tr>
        <td id="L53" class="blob-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L54" class="blob-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-code js-file-line"><span class="c1">#' @param directory The directory which contains scenario folders with</span></td>
      </tr>
      <tr>
        <td id="L55" class="blob-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-code js-file-line"><span class="c1">#'   results.</span></td>
      </tr>
      <tr>
        <td id="L56" class="blob-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-code js-file-line"><span class="c1">#' @param overwrite_files A switch to determine if existing files should be</span></td>
      </tr>
      <tr>
        <td id="L57" class="blob-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-code js-file-line"><span class="c1">#'   overwritten, useful for testing purposes or if new replicates are run.</span></td>
      </tr>
      <tr>
        <td id="L58" class="blob-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-code js-file-line"><span class="c1">#' @param user_scenarios A character vector of scenarios that should be read</span></td>
      </tr>
      <tr>
        <td id="L59" class="blob-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-code js-file-line"><span class="c1">#'   in. Default is NULL, which indicates find all scenario folders in</span></td>
      </tr>
      <tr>
        <td id="L60" class="blob-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-code js-file-line"><span class="c1">#'   \code{directory}.</span></td>
      </tr>
      <tr>
        <td id="L61" class="blob-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-code js-file-line"><span class="c1">#' @param parallel Should the function be run on multiple cores? You will</span></td>
      </tr>
      <tr>
        <td id="L62" class="blob-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-code js-file-line"><span class="c1">#'   need to set up parallel processing as shown in \code{\link{run_ss3sim}}.</span></td>
      </tr>
      <tr>
        <td id="L63" class="blob-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-code js-file-line"><span class="c1">#' @export</span></td>
      </tr>
      <tr>
        <td id="L64" class="blob-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-code js-file-line"><span class="c1">#' @return</span></td>
      </tr>
      <tr>
        <td id="L65" class="blob-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-code js-file-line"><span class="c1">#' Creates two .csv files in the current working directory:</span></td>
      </tr>
      <tr>
        <td id="L66" class="blob-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-code js-file-line"><span class="c1">#' \code{ss3sim_ts.csv} and \code{ss3sim_scalar.csv}.</span></td>
      </tr>
      <tr>
        <td id="L67" class="blob-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-code js-file-line"><span class="c1">#' @author Cole Monnahan</span></td>
      </tr>
      <tr>
        <td id="L68" class="blob-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-code js-file-line"><span class="c1">#' @family get-results</span></td>
      </tr>
      <tr>
        <td id="L69" class="blob-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-code js-file-line"><span class="nf">get_results_all</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">directory</span><span class="o">=</span>getwd(), <span class="nv">overwrite_files</span><span class="o">=</span><span class="kc">FALSE</span>,</td>
      </tr>
      <tr>
        <td id="L70" class="blob-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-code js-file-line">  <span class="nv">user_scenarios</span><span class="o">=</span><span class="kc">NULL</span>, <span class="nv">parallel</span><span class="o">=</span><span class="kc">FALSE</span>){</td>
      </tr>
      <tr>
        <td id="L71" class="blob-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L72" class="blob-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-code js-file-line">    on.exit(setwd(<span class="nv">directory</span>))</td>
      </tr>
      <tr>
        <td id="L73" class="blob-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L74" class="blob-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-code js-file-line">    <span class="k">if</span>(<span class="nv">parallel</span>) {</td>
      </tr>
      <tr>
        <td id="L75" class="blob-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-code js-file-line">      <span class="nv">cores</span> <span class="o">&lt;-</span> setup_parallel()</td>
      </tr>
      <tr>
        <td id="L76" class="blob-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-code js-file-line">      <span class="k">if</span>(<span class="nv">cores</span> <span class="o">==</span> <span class="m">1</span>) <span class="nv">parallel</span> <span class="o">&lt;-</span> <span class="kc">FALSE</span></td>
      </tr>
      <tr>
        <td id="L77" class="blob-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L78" class="blob-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L79" class="blob-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-code js-file-line">    <span class="c1">## Choose whether to do all scenarios or the vector passed by user</span></td>
      </tr>
      <tr>
        <td id="L80" class="blob-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-code js-file-line">    <span class="k">if</span>(is.null(<span class="nv">user_scenarios</span>)) {</td>
      </tr>
      <tr>
        <td id="L81" class="blob-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-code js-file-line">        <span class="nv">scenarios</span> <span class="o">&lt;-</span> id_scenarios(<span class="nv">directory</span><span class="o">=</span><span class="nv">directory</span>)</td>
      </tr>
      <tr>
        <td id="L82" class="blob-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-code js-file-line">    } <span class="k">else</span> {</td>
      </tr>
      <tr>
        <td id="L83" class="blob-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-code js-file-line">        <span class="nv">temp_scenarios</span> <span class="o">&lt;-</span> id_scenarios(<span class="nv">directory</span><span class="o">=</span><span class="nv">directory</span>)</td>
      </tr>
      <tr>
        <td id="L84" class="blob-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-code js-file-line">        <span class="nv">scenarios</span> <span class="o">&lt;-</span> <span class="nv">user_scenarios</span>[which(<span class="nv">user_scenarios</span> <span class="o">%in%</span> <span class="nv">temp_scenarios</span>)]</td>
      </tr>
      <tr>
        <td id="L85" class="blob-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-code js-file-line">        <span class="k">if</span>(any(<span class="nv">user_scenarios</span> <span class="o">%in%</span> <span class="nv">temp_scenarios</span><span class="o">==</span><span class="kc">FALSE</span>)){</td>
      </tr>
      <tr>
        <td id="L86" class="blob-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-code js-file-line">            warning(paste(<span class="nv">user_scenarios</span>[which(<span class="nv">user_scenarios</span> <span class="o">%in%</span></td>
      </tr>
      <tr>
        <td id="L87" class="blob-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-code js-file-line">                <span class="nv">temp_scenarios</span> <span class="o">==</span> <span class="kc">FALSE</span>)], <span class="s2">&quot;not in directory<span class="sc">\n</span>&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L88" class="blob-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-code js-file-line">        }</td>
      </tr>
      <tr>
        <td id="L89" class="blob-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L90" class="blob-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L91" class="blob-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-code js-file-line">    <span class="k">if</span>(length(<span class="nv">scenarios</span>)<span class="o">==</span><span class="m">0</span>)</td>
      </tr>
      <tr>
        <td id="L92" class="blob-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-code js-file-line">        stop(paste(<span class="s2">&quot;Error: No scenarios found in:&quot;</span>,<span class="nv">directory</span>))</td>
      </tr>
      <tr>
        <td id="L93" class="blob-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-code js-file-line">    message(paste(<span class="s2">&quot;Extracting results from&quot;</span>, length(<span class="nv">scenarios</span>), <span class="s2">&quot;scenarios&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L94" class="blob-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L95" class="blob-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-code js-file-line">    <span class="k">if</span>(<span class="nv">parallel</span>){</td>
      </tr>
      <tr>
        <td id="L96" class="blob-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-code js-file-line">        <span class="nv">parallel_scenario</span> <span class="o">&lt;-</span> <span class="kc">NULL</span></td>
      </tr>
      <tr>
        <td id="L97" class="blob-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-code js-file-line">        <span class="c1"># ts.list &lt;- scalar.list &lt;- list()</span></td>
      </tr>
      <tr>
        <td id="L98" class="blob-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-code js-file-line">        <span class="nv">results_all</span> <span class="o">&lt;-</span> foreach(<span class="nv">parallel_scenario</span> <span class="o">=</span> <span class="nv">scenarios</span>, <span class="nv">.verbose</span> <span class="o">=</span> <span class="kc">FALSE</span>,</td>
      </tr>
      <tr>
        <td id="L99" class="blob-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-code js-file-line">            <span class="nv">.export</span> <span class="o">=</span> c(<span class="s2">&quot;pastef&quot;</span>, <span class="s2">&quot;get_results_scenario&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L100" class="blob-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-code js-file-line">            <span class="s2">&quot;get_results_scalar&quot;</span>, <span class="s2">&quot;get_nll_components&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L101" class="blob-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-code js-file-line">            <span class="s2">&quot;get_results_timeseries&quot;</span>, <span class="s2">&quot;calculate_runtime&quot;</span>), <span class="nv">.combine</span> <span class="o">=</span> <span class="nv">rbind</span>) %<span class="nv">dopar</span>% {</td>
      </tr>
      <tr>
        <td id="L102" class="blob-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-code js-file-line">            <span class="c1">## If the files already exist just read them in, otherwise get results</span></td>
      </tr>
      <tr>
        <td id="L103" class="blob-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-code js-file-line">                <span class="nv">scalar.file</span> <span class="o">&lt;-</span> paste0(<span class="nv">parallel_scenario</span>,<span class="s2">&quot;/results_scalar_&quot;</span>,<span class="nv">parallel_scenario</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L104" class="blob-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-code js-file-line">                <span class="nv">ts.file</span> <span class="o">&lt;-</span> paste0(<span class="nv">parallel_scenario</span>,<span class="s2">&quot;/results_ts_&quot;</span>,<span class="nv">parallel_scenario</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L105" class="blob-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-code js-file-line">                <span class="c1">## Delete them if this is flagged on</span></td>
      </tr>
      <tr>
        <td id="L106" class="blob-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-code js-file-line">                <span class="k">if</span>( <span class="nv">overwrite_files</span>){</td>
      </tr>
      <tr>
        <td id="L107" class="blob-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-code js-file-line">                    <span class="k">if</span>(file.exists(<span class="nv">scalar.file</span>)) file.remove(<span class="nv">scalar.file</span>)</td>
      </tr>
      <tr>
        <td id="L108" class="blob-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-code js-file-line">                    <span class="k">if</span>(file.exists(<span class="nv">ts.file</span>)) file.remove(<span class="nv">ts.file</span>)</td>
      </tr>
      <tr>
        <td id="L109" class="blob-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-code js-file-line">                    get_results_scenario(<span class="nv">scenario</span><span class="o">=</span><span class="nv">parallel_scenario</span>, <span class="nv">directory</span><span class="o">=</span><span class="nv">directory</span>,</td>
      </tr>
      <tr>
        <td id="L110" class="blob-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-code js-file-line">                                         <span class="nv">overwrite_files</span><span class="o">=</span><span class="nv">overwrite_files</span>)</td>
      </tr>
      <tr>
        <td id="L111" class="blob-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-code js-file-line">                }</td>
      </tr>
      <tr>
        <td id="L112" class="blob-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-code js-file-line">                <span class="c1">## Check if still there and skip if already so, otherwise read in</span></td>
      </tr>
      <tr>
        <td id="L113" class="blob-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-code js-file-line">                <span class="c1">## and save to file</span></td>
      </tr>
      <tr>
        <td id="L114" class="blob-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-code js-file-line">                <span class="k">if</span>(<span class="o">!</span>file.exists(<span class="nv">scalar.file</span>) <span class="o">|</span>  <span class="o">!</span>file.exists(<span class="nv">ts.file</span>)){</td>
      </tr>
      <tr>
        <td id="L115" class="blob-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-code js-file-line">                    get_results_scenario(<span class="nv">scenario</span><span class="o">=</span><span class="nv">parallel_scenario</span>, <span class="nv">directory</span><span class="o">=</span><span class="nv">directory</span>,</td>
      </tr>
      <tr>
        <td id="L116" class="blob-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-code js-file-line">                                         <span class="nv">overwrite_files</span><span class="o">=</span><span class="nv">overwrite_files</span>)</td>
      </tr>
      <tr>
        <td id="L117" class="blob-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-code js-file-line">                }</td>
      </tr>
      <tr>
        <td id="L118" class="blob-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-code js-file-line">        }</td>
      </tr>
      <tr>
        <td id="L119" class="blob-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-code js-file-line">        <span class="nv">ts.list</span> <span class="o">&lt;-</span> <span class="nv">scalar.list</span> <span class="o">&lt;-</span> <span class="kt">list</span>()</td>
      </tr>
      <tr>
        <td id="L120" class="blob-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-code js-file-line">        <span class="nv">flag.na</span> <span class="o">&lt;-</span> rep(<span class="m">0</span>, length(<span class="nv">scenarios</span>))</td>
      </tr>
      <tr>
        <td id="L121" class="blob-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-code js-file-line">        <span class="k">for</span>(<span class="nv">i</span> <span class="k">in</span> <span class="m">1</span><span class="k">:</span>length(<span class="nv">scenarios</span>)){</td>
      </tr>
      <tr>
        <td id="L122" class="blob-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-code js-file-line">            <span class="nv">scalar.file</span> <span class="o">&lt;-</span> paste0(<span class="nv">scenarios</span>[<span class="nv">i</span>],<span class="s2">&quot;/results_scalar_&quot;</span>,<span class="nv">scenarios</span>[<span class="nv">i</span>],<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L123" class="blob-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-code js-file-line">            <span class="nv">ts.file</span> <span class="o">&lt;-</span> paste0(<span class="nv">scenarios</span>[<span class="nv">i</span>],<span class="s2">&quot;/results_ts_&quot;</span>,<span class="nv">scenarios</span>[<span class="nv">i</span>],<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L124" class="blob-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-code js-file-line">            <span class="nv">scalar.list</span>[[<span class="nv">i</span>]] <span class="o">&lt;-</span> tryCatch(read.csv(<span class="nv">scalar.file</span>), <span class="nv">error</span><span class="o">=</span><span class="k">function</span>(<span class="nv">e</span>) <span class="kc">NA</span>)</td>
      </tr>
      <tr>
        <td id="L125" class="blob-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-code js-file-line">            <span class="nv">ts.list</span>[[<span class="nv">i</span>]] <span class="o">&lt;-</span> tryCatch(read.csv(<span class="nv">ts.file</span>), <span class="nv">error</span><span class="o">=</span><span class="k">function</span>(<span class="nv">e</span>) <span class="kc">NA</span>)</td>
      </tr>
      <tr>
        <td id="L126" class="blob-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-code js-file-line">            <span class="k">if</span>(all(is.na(<span class="nv">scalar.list</span>[[<span class="nv">i</span>]]))){<span class="nv">flag.na</span>[<span class="nv">i</span>] <span class="o">&lt;-</span> <span class="m">1</span>}</td>
      </tr>
      <tr>
        <td id="L127" class="blob-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-code js-file-line">        }</td>
      </tr>
      <tr>
        <td id="L128" class="blob-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-code js-file-line">        <span class="nv">scalar.list.out</span> <span class="o">&lt;-</span> <span class="nv">scalar.list</span>[<span class="o">-</span>which(<span class="nv">flag.na</span><span class="o">==</span><span class="m">1</span>)]</td>
      </tr>
      <tr>
        <td id="L129" class="blob-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-code js-file-line">        <span class="nv">ts.list.out</span> <span class="o">&lt;-</span> <span class="nv">ts.list</span>[<span class="o">-</span>which(<span class="nv">flag.na</span><span class="o">==</span><span class="m">1</span>)]</td>
      </tr>
      <tr>
        <td id="L130" class="blob-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-code js-file-line">        <span class="c1">## Combine all scenarios together and save into big final files</span></td>
      </tr>
      <tr>
        <td id="L131" class="blob-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-code js-file-line">        <span class="nv">scalar.all</span> <span class="o">&lt;-</span> do.call(plyr<span class="k">::</span><span class="nv">rbind.fill</span>, <span class="nv">scalar.list.out</span>)</td>
      </tr>
      <tr>
        <td id="L132" class="blob-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-code js-file-line">        <span class="nv">scalar.all</span><span class="k">$</span><span class="nv">ID</span> <span class="o">&lt;-</span> paste(<span class="nv">scalar.all</span><span class="k">$</span><span class="nv">scenario</span>, <span class="nv">scalar.all</span><span class="k">$</span><span class="nv">replicate</span>, <span class="nv">sep</span> <span class="o">=</span> <span class="s2">&quot;-&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L133" class="blob-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-code js-file-line">        <span class="nv">ts.all</span> <span class="o">&lt;-</span> do.call(plyr<span class="k">::</span><span class="nv">rbind.fill</span>, <span class="nv">ts.list.out</span>)</td>
      </tr>
      <tr>
        <td id="L134" class="blob-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-code js-file-line">        <span class="nv">ts.all</span><span class="k">$</span><span class="nv">ID</span> <span class="o">&lt;-</span> paste(<span class="nv">ts.all</span><span class="k">$</span><span class="nv">scenario</span>, <span class="nv">ts.all</span><span class="k">$</span><span class="nv">replicate</span>, <span class="nv">sep</span><span class="o">=</span><span class="s2">&quot;-&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L135" class="blob-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-code js-file-line">        write.csv(<span class="nv">scalar.all</span>, <span class="nv">file</span><span class="o">=</span><span class="s2">&quot;ss3sim_scalar.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L136" class="blob-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-code js-file-line">        write.csv(<span class="nv">ts.all</span>, <span class="nv">file</span><span class="o">=</span><span class="s2">&quot;ss3sim_ts.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L137" class="blob-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-code js-file-line">        message(paste(<span class="s2">&quot;Final result files written to&quot;</span>, <span class="nv">directory</span>))</td>
      </tr>
      <tr>
        <td id="L138" class="blob-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-code js-file-line">    } <span class="k">else</span>{</td>
      </tr>
      <tr>
        <td id="L139" class="blob-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-code js-file-line">    <span class="c1">## Loop through each scenario in folder</span></td>
      </tr>
      <tr>
        <td id="L140" class="blob-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-code js-file-line">    <span class="nv">ts.list</span> <span class="o">&lt;-</span> <span class="nv">scalar.list</span> <span class="o">&lt;-</span> <span class="kt">list</span>()</td>
      </tr>
      <tr>
        <td id="L141" class="blob-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-code js-file-line">    <span class="k">for</span>(<span class="nv">i</span> <span class="k">in</span> <span class="m">1</span><span class="k">:</span>length(<span class="nv">scenarios</span>)){</td>
      </tr>
      <tr>
        <td id="L142" class="blob-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-code js-file-line">        setwd(<span class="nv">directory</span>)</td>
      </tr>
      <tr>
        <td id="L143" class="blob-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-code js-file-line">        <span class="nv">scen</span> <span class="o">&lt;-</span> <span class="nv">scenarios</span>[<span class="nv">i</span>]</td>
      </tr>
      <tr>
        <td id="L144" class="blob-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-code js-file-line">        <span class="c1">## If the files already exist just read them in, otherwise get results</span></td>
      </tr>
      <tr>
        <td id="L145" class="blob-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-code js-file-line">        <span class="nv">scalar.file</span> <span class="o">&lt;-</span> paste0(<span class="nv">scen</span>,<span class="s2">&quot;/results_scalar_&quot;</span>,<span class="nv">scen</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L146" class="blob-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-code js-file-line">        <span class="nv">ts.file</span> <span class="o">&lt;-</span> paste0(<span class="nv">scen</span>,<span class="s2">&quot;/results_ts_&quot;</span>,<span class="nv">scen</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L147" class="blob-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-code js-file-line">        <span class="c1">## Delete them if this is flagged on</span></td>
      </tr>
      <tr>
        <td id="L148" class="blob-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-code js-file-line">        <span class="k">if</span>( <span class="nv">overwrite_files</span>){</td>
      </tr>
      <tr>
        <td id="L149" class="blob-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-code js-file-line">            <span class="k">if</span>(file.exists(<span class="nv">scalar.file</span>)) file.remove(<span class="nv">scalar.file</span>)</td>
      </tr>
      <tr>
        <td id="L150" class="blob-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-code js-file-line">            <span class="k">if</span>(file.exists(<span class="nv">ts.file</span>)) file.remove(<span class="nv">ts.file</span>)</td>
      </tr>
      <tr>
        <td id="L151" class="blob-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-code js-file-line">            get_results_scenario(<span class="nv">scenario</span><span class="o">=</span><span class="nv">scen</span>, <span class="nv">directory</span><span class="o">=</span><span class="nv">directory</span>,</td>
      </tr>
      <tr>
        <td id="L152" class="blob-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-code js-file-line">                                 <span class="nv">overwrite_files</span><span class="o">=</span><span class="nv">overwrite_files</span>)</td>
      </tr>
      <tr>
        <td id="L153" class="blob-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-code js-file-line">        }</td>
      </tr>
      <tr>
        <td id="L154" class="blob-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-code js-file-line">        <span class="c1">## Check if still there and skip if already so, otherwise read in</span></td>
      </tr>
      <tr>
        <td id="L155" class="blob-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-code js-file-line">        <span class="c1">## and save to file</span></td>
      </tr>
      <tr>
        <td id="L156" class="blob-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-code js-file-line">        <span class="k">if</span>(<span class="o">!</span>file.exists(<span class="nv">scalar.file</span>) <span class="o">|</span>  <span class="o">!</span>file.exists(<span class="nv">ts.file</span>)){</td>
      </tr>
      <tr>
        <td id="L157" class="blob-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-code js-file-line">            get_results_scenario(<span class="nv">scenario</span><span class="o">=</span><span class="nv">scen</span>, <span class="nv">directory</span><span class="o">=</span><span class="nv">directory</span>,</td>
      </tr>
      <tr>
        <td id="L158" class="blob-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-code js-file-line">                                 <span class="nv">overwrite_files</span><span class="o">=</span><span class="nv">overwrite_files</span>)</td>
      </tr>
      <tr>
        <td id="L159" class="blob-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-code js-file-line">        }</td>
      </tr>
      <tr>
        <td id="L160" class="blob-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-code js-file-line">        <span class="nv">scalar.list</span>[[<span class="nv">i</span>]] <span class="o">&lt;-</span> tryCatch(read.csv(<span class="nv">scalar.file</span>), <span class="nv">error</span><span class="o">=</span><span class="k">function</span>(<span class="nv">e</span>) <span class="kc">NA</span>)</td>
      </tr>
      <tr>
        <td id="L161" class="blob-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-code js-file-line">        <span class="nv">ts.list</span>[[<span class="nv">i</span>]] <span class="o">&lt;-</span> tryCatch(read.csv(<span class="nv">ts.file</span>), <span class="nv">error</span><span class="o">=</span><span class="k">function</span>(<span class="nv">e</span>) <span class="kc">NA</span>)</td>
      </tr>
      <tr>
        <td id="L162" class="blob-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L163" class="blob-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-code js-file-line">    <span class="nv">scalar.list</span> <span class="o">&lt;-</span> <span class="nv">scalar.list</span>[<span class="o">-</span>is.na(<span class="nv">scalar.list</span>)]</td>
      </tr>
      <tr>
        <td id="L164" class="blob-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-code js-file-line">    <span class="nv">ts.list</span> <span class="o">&lt;-</span> <span class="nv">ts.list</span>[<span class="o">-</span>is.na(<span class="nv">ts.list</span>)]</td>
      </tr>
      <tr>
        <td id="L165" class="blob-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-code js-file-line">    <span class="c1">## Combine all scenarios together and save into big final files</span></td>
      </tr>
      <tr>
        <td id="L166" class="blob-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-code js-file-line">    <span class="nv">scalar.all</span> <span class="o">&lt;-</span> do.call(plyr<span class="k">::</span><span class="nv">rbind.fill</span>, <span class="nv">scalar.list</span>)</td>
      </tr>
      <tr>
        <td id="L167" class="blob-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-code js-file-line">    <span class="nv">scalar.all</span><span class="k">$</span><span class="nv">ID</span> <span class="o">&lt;-</span> paste(<span class="nv">scalar.all</span><span class="k">$</span><span class="nv">scenario</span>, <span class="nv">scalar.all</span><span class="k">$</span><span class="nv">replicate</span>, <span class="nv">sep</span> <span class="o">=</span> <span class="s2">&quot;-&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L168" class="blob-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-code js-file-line">    <span class="nv">ts.all</span> <span class="o">&lt;-</span> do.call(plyr<span class="k">::</span><span class="nv">rbind.fill</span>, <span class="nv">ts.list</span>)</td>
      </tr>
      <tr>
        <td id="L169" class="blob-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-code js-file-line">    <span class="nv">ts.all</span><span class="k">$</span><span class="nv">ID</span> <span class="o">&lt;-</span> paste(<span class="nv">ts.all</span><span class="k">$</span><span class="nv">scenario</span>, <span class="nv">ts.all</span><span class="k">$</span><span class="nv">replicate</span>, <span class="nv">sep</span><span class="o">=</span><span class="s2">&quot;-&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L170" class="blob-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-code js-file-line">    write.csv(<span class="nv">scalar.all</span>, <span class="nv">file</span><span class="o">=</span><span class="s2">&quot;ss3sim_scalar.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L171" class="blob-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-code js-file-line">    write.csv(<span class="nv">ts.all</span>, <span class="nv">file</span><span class="o">=</span><span class="s2">&quot;ss3sim_ts.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L172" class="blob-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-code js-file-line">    message(paste(<span class="s2">&quot;Final result files written to&quot;</span>, <span class="nv">directory</span>))</td>
      </tr>
      <tr>
        <td id="L173" class="blob-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-code js-file-line">  }</td>
      </tr>
      <tr>
        <td id="L174" class="blob-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-code js-file-line">}</td>
      </tr>
      <tr>
        <td id="L175" class="blob-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L176" class="blob-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-code js-file-line"><span class="c1">#' Extract SS3 simulation results for one scenario.</span></td>
      </tr>
      <tr>
        <td id="L177" class="blob-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L178" class="blob-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-code js-file-line"><span class="c1">#' Function that extracts results from all replicates inside a supplied</span></td>
      </tr>
      <tr>
        <td id="L179" class="blob-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-code js-file-line"><span class="c1">#' scenario folder. The function writes 3 .csv files to the scenario folder:</span></td>
      </tr>
      <tr>
        <td id="L180" class="blob-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-code js-file-line"><span class="c1">#' (1) scalar metrics with one value per replicate (e.g. $R_0$, $h$), (2) a</span></td>
      </tr>
      <tr>
        <td id="L181" class="blob-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-code js-file-line"><span class="c1">#' timeseries data ('ts') which contains multiple values per replicate (e.g.</span></td>
      </tr>
      <tr>
        <td id="L182" class="blob-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-code js-file-line"><span class="c1">#' $SSB_y$ for a range of years $y$), and (3) residuals on the log scale from</span></td>
      </tr>
      <tr>
        <td id="L183" class="blob-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-code js-file-line"><span class="c1">#' the surveys across all replicates (this feature is not fully tested!). The</span></td>
      </tr>
      <tr>
        <td id="L184" class="blob-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-code js-file-line"><span class="c1">#' function \code{get_results_all} loops through these .csv files and combines</span></td>
      </tr>
      <tr>
        <td id="L185" class="blob-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-code js-file-line"><span class="c1">#' them together into a single &quot;final&quot; dataframe.</span></td>
      </tr>
      <tr>
        <td id="L186" class="blob-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L187" class="blob-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-code js-file-line"><span class="c1">#' @param scenario A single character giving the scenario from which to</span></td>
      </tr>
      <tr>
        <td id="L188" class="blob-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-code js-file-line"><span class="c1">#'   extract results.</span></td>
      </tr>
      <tr>
        <td id="L189" class="blob-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-code js-file-line"><span class="c1">#' @param directory The directory which contains the scenario folder.</span></td>
      </tr>
      <tr>
        <td id="L190" class="blob-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-code js-file-line"><span class="c1">#' @param overwrite_files A boolean (default is FALSE) for whether to delete</span></td>
      </tr>
      <tr>
        <td id="L191" class="blob-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-code js-file-line"><span class="c1">#'   any files previously created with this function. This is intended to be</span></td>
      </tr>
      <tr>
        <td id="L192" class="blob-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-code js-file-line"><span class="c1">#'   used if replicates were added since the last time it was called, or any</span></td>
      </tr>
      <tr>
        <td id="L193" class="blob-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-code js-file-line"><span class="c1">#'   changes were made to this function.</span></td>
      </tr>
      <tr>
        <td id="L194" class="blob-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-code js-file-line"><span class="c1">#' @author Cole Monnahan</span></td>
      </tr>
      <tr>
        <td id="L195" class="blob-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-code js-file-line"><span class="c1">#' @family get-results</span></td>
      </tr>
      <tr>
        <td id="L196" class="blob-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-code js-file-line"><span class="c1">#' @export</span></td>
      </tr>
      <tr>
        <td id="L197" class="blob-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-code js-file-line"><span class="c1">#' @examples \dontrun{</span></td>
      </tr>
      <tr>
        <td id="L198" class="blob-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-code js-file-line"><span class="c1">#' d &lt;- system.file(&quot;extdata&quot;, package = &quot;ss3sim&quot;)</span></td>
      </tr>
      <tr>
        <td id="L199" class="blob-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-code js-file-line"><span class="c1">#' case_folder &lt;- paste0(d, &quot;/eg-cases&quot;)</span></td>
      </tr>
      <tr>
        <td id="L200" class="blob-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-code js-file-line"><span class="c1">#' om &lt;- paste0(d, &quot;/models/cod-om&quot;)</span></td>
      </tr>
      <tr>
        <td id="L201" class="blob-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-code js-file-line"><span class="c1">#' em &lt;- paste0(d, &quot;/models/cod-em&quot;)</span></td>
      </tr>
      <tr>
        <td id="L202" class="blob-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-code js-file-line"><span class="c1">#' run_ss3sim(iterations = 1:2, scenarios =</span></td>
      </tr>
      <tr>
        <td id="L203" class="blob-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-code js-file-line"><span class="c1">#'   c(&quot;D0-E0-F0-G0-R0-S0-M0-cod&quot;),</span></td>
      </tr>
      <tr>
        <td id="L204" class="blob-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-code js-file-line"><span class="c1">#'   case_folder = case_folder, om_dir = om, em_dir = em,</span></td>
      </tr>
      <tr>
        <td id="L205" class="blob-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-code js-file-line"><span class="c1">#'   bias_adjust = FALSE)</span></td>
      </tr>
      <tr>
        <td id="L206" class="blob-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-code js-file-line"><span class="c1">#' get_results_scenario(c(&quot;D0-E0-F0-G0-R0-S0-M0-cod&quot;))</span></td>
      </tr>
      <tr>
        <td id="L207" class="blob-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-code js-file-line"><span class="c1">#' }</span></td>
      </tr>
      <tr>
        <td id="L208" class="blob-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-code js-file-line"><span class="nf">get_results_scenario</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">scenario</span>, <span class="nv">directory</span><span class="o">=</span>getwd(),</td>
      </tr>
      <tr>
        <td id="L209" class="blob-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-code js-file-line">  <span class="nv">overwrite_files</span><span class="o">=</span><span class="kc">FALSE</span>){</td>
      </tr>
      <tr>
        <td id="L210" class="blob-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-code js-file-line">    <span class="c1">## This function moves the wd around so make sure to reset on exit,</span></td>
      </tr>
      <tr>
        <td id="L211" class="blob-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-code js-file-line">    <span class="c1">## especially in case of an error</span></td>
      </tr>
      <tr>
        <td id="L212" class="blob-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-code js-file-line">    <span class="nv">old_wd</span> <span class="o">&lt;-</span> getwd()</td>
      </tr>
      <tr>
        <td id="L213" class="blob-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-code js-file-line">    on.exit(setwd(<span class="nv">old_wd</span>))</td>
      </tr>
      <tr>
        <td id="L214" class="blob-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-code js-file-line">    <span class="k">if</span> (file.exists(pastef(<span class="nv">directory</span>, <span class="nv">scenario</span>))) {</td>
      </tr>
      <tr>
        <td id="L215" class="blob-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-code js-file-line">      setwd(pastef(<span class="nv">directory</span>, <span class="nv">scenario</span>))</td>
      </tr>
      <tr>
        <td id="L216" class="blob-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-code js-file-line">    } <span class="k">else</span> {</td>
      </tr>
      <tr>
        <td id="L217" class="blob-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-code js-file-line">      stop(paste(<span class="s2">&quot;Scenario&quot;</span>, <span class="nv">scenario</span>, <span class="s2">&quot;does not exist in&quot;</span>, <span class="nv">directory</span>))</td>
      </tr>
      <tr>
        <td id="L218" class="blob-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L219" class="blob-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-code js-file-line">    <span class="c1">## Stop if the files already exist or maybe delete them</span></td>
      </tr>
      <tr>
        <td id="L220" class="blob-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-code js-file-line">    <span class="nv">scalar.file</span> <span class="o">&lt;-</span> paste0(<span class="s2">&quot;results_scalar_&quot;</span>,<span class="nv">scenario</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L221" class="blob-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-code js-file-line">    <span class="nv">ts.file</span> <span class="o">&lt;-</span> paste0(<span class="s2">&quot;results_ts_&quot;</span>,<span class="nv">scenario</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L222" class="blob-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-code js-file-line">    <span class="nv">resids.file</span> <span class="o">&lt;-</span> paste0(<span class="s2">&quot;results_resids_&quot;</span>,<span class="nv">scenario</span>,<span class="s2">&quot;.csv&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L223" class="blob-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-code js-file-line">    <span class="k">if</span>(file.exists(<span class="nv">scalar.file</span>) <span class="o">|</span> file.exists(<span class="nv">ts.file</span>)){</td>
      </tr>
      <tr>
        <td id="L224" class="blob-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-code js-file-line">        <span class="k">if</span>(<span class="nv">overwrite_files</span>) {</td>
      </tr>
      <tr>
        <td id="L225" class="blob-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-code js-file-line">            <span class="c1">## Delete them and continue</span></td>
      </tr>
      <tr>
        <td id="L226" class="blob-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-code js-file-line">            message(paste0(<span class="s2">&quot;Files deleted for &quot;</span>, <span class="nv">scenario</span>))</td>
      </tr>
      <tr>
        <td id="L227" class="blob-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-code js-file-line">            file.remove(<span class="nv">scalar.file</span>, <span class="nv">ts.file</span>)</td>
      </tr>
      <tr>
        <td id="L228" class="blob-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-code js-file-line">        } <span class="k">else</span> {</td>
      </tr>
      <tr>
        <td id="L229" class="blob-num js-line-number" data-line-number="229"></td>
        <td id="LC229" class="blob-code js-file-line">            <span class="c1">## Stop the progress</span></td>
      </tr>
      <tr>
        <td id="L230" class="blob-num js-line-number" data-line-number="230"></td>
        <td id="LC230" class="blob-code js-file-line">            stop(paste0(<span class="s2">&quot;Files already exist for &quot;</span>, <span class="nv">scenario</span>,<span class="s2">&quot;</span></td>
      </tr>
      <tr>
        <td id="L231" class="blob-num js-line-number" data-line-number="231"></td>
        <td id="LC231" class="blob-code js-file-line"><span class="s2">              and overwrite_files=FALSE&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L232" class="blob-num js-line-number" data-line-number="232"></td>
        <td id="LC232" class="blob-code js-file-line">        }</td>
      </tr>
      <tr>
        <td id="L233" class="blob-num js-line-number" data-line-number="233"></td>
        <td id="LC233" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L234" class="blob-num js-line-number" data-line-number="234"></td>
        <td id="LC234" class="blob-code js-file-line">    <span class="c1">## Check for bias correction for this scenario, grab it if exists otherwise</span></td>
      </tr>
      <tr>
        <td id="L235" class="blob-num js-line-number" data-line-number="235"></td>
        <td id="LC235" class="blob-code js-file-line">    <span class="c1">## report NAs</span></td>
      </tr>
      <tr>
        <td id="L236" class="blob-num js-line-number" data-line-number="236"></td>
        <td id="LC236" class="blob-code js-file-line">    <span class="nv">bias</span> <span class="o">&lt;-</span> rep(<span class="kc">NA</span>,<span class="m">7</span>)</td>
      </tr>
      <tr>
        <td id="L237" class="blob-num js-line-number" data-line-number="237"></td>
        <td id="LC237" class="blob-code js-file-line">    names(<span class="nv">bias</span>) <span class="o">&lt;-</span> c(<span class="s2">&quot;bias1&quot;</span>,<span class="s2">&quot;bias2&quot;</span>,<span class="s2">&quot;bias3&quot;</span>,<span class="s2">&quot;bias4&quot;</span>,<span class="s2">&quot;bias5&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L238" class="blob-num js-line-number" data-line-number="238"></td>
        <td id="LC238" class="blob-code js-file-line">                     <span class="s2">&quot;bias.converged&quot;</span>,<span class="s2">&quot;bias.tried&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L239" class="blob-num js-line-number" data-line-number="239"></td>
        <td id="LC239" class="blob-code js-file-line">    <span class="k">if</span>(length(grep(<span class="s2">&quot;bias&quot;</span>, dir()))<span class="o">==</span><span class="m">1</span>){</td>
      </tr>
      <tr>
        <td id="L240" class="blob-num js-line-number" data-line-number="240"></td>
        <td id="LC240" class="blob-code js-file-line">        <span class="nv">bias</span>[<span class="m">1</span><span class="k">:</span><span class="m">5</span>] <span class="o">&lt;-</span> unlist(read.table(<span class="nv">file</span><span class="o">=</span><span class="s2">&quot;bias/AvgBias.DAT&quot;</span>, <span class="nv">header</span><span class="o">=</span><span class="kc">TRUE</span>))</td>
      </tr>
      <tr>
        <td id="L241" class="blob-num js-line-number" data-line-number="241"></td>
        <td id="LC241" class="blob-code js-file-line">        <span class="nv">bias.file</span> <span class="o">&lt;-</span> read.table(<span class="nv">file</span><span class="o">=</span><span class="s2">&quot;bias/AdjustBias.DAT&quot;</span>, <span class="nv">header</span><span class="o">=</span><span class="kc">FALSE</span>)</td>
      </tr>
      <tr>
        <td id="L242" class="blob-num js-line-number" data-line-number="242"></td>
        <td id="LC242" class="blob-code js-file-line">        <span class="c1">## The ones with NAs mean it didn't converge</span></td>
      </tr>
      <tr>
        <td id="L243" class="blob-num js-line-number" data-line-number="243"></td>
        <td id="LC243" class="blob-code js-file-line">        <span class="nv">bias</span>[<span class="m">6</span>] <span class="o">&lt;-</span> nrow(na.omit(<span class="nv">bias.file</span>))</td>
      </tr>
      <tr>
        <td id="L244" class="blob-num js-line-number" data-line-number="244"></td>
        <td id="LC244" class="blob-code js-file-line">        <span class="nv">bias</span>[<span class="m">7</span>] <span class="o">&lt;-</span> nrow(<span class="nv">bias.file</span>)</td>
      </tr>
      <tr>
        <td id="L245" class="blob-num js-line-number" data-line-number="245"></td>
        <td id="LC245" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L246" class="blob-num js-line-number" data-line-number="246"></td>
        <td id="LC246" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L247" class="blob-num js-line-number" data-line-number="247"></td>
        <td id="LC247" class="blob-code js-file-line">    <span class="c1">## Loop through each replicate, not including the bias folders, and get</span></td>
      </tr>
      <tr>
        <td id="L248" class="blob-num js-line-number" data-line-number="248"></td>
        <td id="LC248" class="blob-code js-file-line">    <span class="c1">## results from both models</span></td>
      </tr>
      <tr>
        <td id="L249" class="blob-num js-line-number" data-line-number="249"></td>
        <td id="LC249" class="blob-code js-file-line">    <span class="c1">## Remove the .csv files and bias folder, they are not reps</span></td>
      </tr>
      <tr>
        <td id="L250" class="blob-num js-line-number" data-line-number="250"></td>
        <td id="LC250" class="blob-code js-file-line">    <span class="nv">reps.dirs</span> <span class="o">&lt;-</span> list.files(<span class="nv">pattern</span> <span class="o">=</span> <span class="s2">&quot;[0-9]+$&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L251" class="blob-num js-line-number" data-line-number="251"></td>
        <td id="LC251" class="blob-code js-file-line">    <span class="nv">reps.dirs</span> <span class="o">&lt;-</span> sort(as.numeric(<span class="nv">reps.dirs</span>))</td>
      </tr>
      <tr>
        <td id="L252" class="blob-num js-line-number" data-line-number="252"></td>
        <td id="LC252" class="blob-code js-file-line">    <span class="k">if</span>(length(<span class="nv">reps.dirs</span>)<span class="o">==</span><span class="m">0</span>)</td>
      </tr>
      <tr>
        <td id="L253" class="blob-num js-line-number" data-line-number="253"></td>
        <td id="LC253" class="blob-code js-file-line">        stop(paste(<span class="s2">&quot;Error:No replicates for scenario&quot;</span>, <span class="nv">scenario</span>))</td>
      </tr>
      <tr>
        <td id="L254" class="blob-num js-line-number" data-line-number="254"></td>
        <td id="LC254" class="blob-code js-file-line">    <span class="c1">## Loop through replicates and extract results using r4ss::SS_output</span></td>
      </tr>
      <tr>
        <td id="L255" class="blob-num js-line-number" data-line-number="255"></td>
        <td id="LC255" class="blob-code js-file-line">    <span class="nv">resids.list</span> <span class="o">&lt;-</span> <span class="kt">list</span>()</td>
      </tr>
      <tr>
        <td id="L256" class="blob-num js-line-number" data-line-number="256"></td>
        <td id="LC256" class="blob-code js-file-line">    <span class="c1">## count replicates that didn't run SS successfully</span></td>
      </tr>
      <tr>
        <td id="L257" class="blob-num js-line-number" data-line-number="257"></td>
        <td id="LC257" class="blob-code js-file-line">    <span class="nv">no.rep</span> <span class="o">&lt;-</span> <span class="m">0</span></td>
      </tr>
      <tr>
        <td id="L258" class="blob-num js-line-number" data-line-number="258"></td>
        <td id="LC258" class="blob-code js-file-line">    <span class="k">for</span>(<span class="nv">rep</span> <span class="k">in</span> <span class="nv">reps.dirs</span>){</td>
      </tr>
      <tr>
        <td id="L259" class="blob-num js-line-number" data-line-number="259"></td>
        <td id="LC259" class="blob-code js-file-line">        <span class="c1">## message(paste0(&quot;Starting&quot;, scen, &quot;-&quot;, rep))</span></td>
      </tr>
      <tr>
        <td id="L260" class="blob-num js-line-number" data-line-number="260"></td>
        <td id="LC260" class="blob-code js-file-line">      <span class="nv">report.em</span> <span class="o">&lt;-</span> r4ss<span class="k">::</span>SS_output(paste0(<span class="nv">rep</span>,<span class="s2">&quot;/em/&quot;</span>), <span class="nv">covar</span><span class="o">=</span><span class="kc">FALSE</span>,</td>
      </tr>
      <tr>
        <td id="L261" class="blob-num js-line-number" data-line-number="261"></td>
        <td id="LC261" class="blob-code js-file-line">        <span class="nv">verbose</span><span class="o">=</span><span class="kc">FALSE</span>,<span class="nv">compfile</span><span class="o">=</span><span class="s2">&quot;none&quot;</span>, <span class="nv">forecast</span><span class="o">=</span><span class="kc">TRUE</span>, <span class="nv">warn</span><span class="o">=</span><span class="kc">TRUE</span>, <span class="nv">readwt</span><span class="o">=</span><span class="kc">FALSE</span>,</td>
      </tr>
      <tr>
        <td id="L262" class="blob-num js-line-number" data-line-number="262"></td>
        <td id="LC262" class="blob-code js-file-line">        <span class="nv">printstats</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">NoCompOK</span><span class="o">=</span><span class="kc">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L263" class="blob-num js-line-number" data-line-number="263"></td>
        <td id="LC263" class="blob-code js-file-line">      <span class="nv">report.om</span> <span class="o">&lt;-</span> tryCatch(r4ss<span class="k">::</span>SS_output(paste0(<span class="nv">rep</span>,<span class="s2">&quot;/om/&quot;</span>), <span class="nv">covar</span><span class="o">=</span><span class="kc">FALSE</span>,</td>
      </tr>
      <tr>
        <td id="L264" class="blob-num js-line-number" data-line-number="264"></td>
        <td id="LC264" class="blob-code js-file-line">        <span class="nv">verbose</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">compfile</span><span class="o">=</span><span class="s2">&quot;none&quot;</span>, <span class="nv">forecast</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">warn</span><span class="o">=</span><span class="kc">TRUE</span>, <span class="nv">readwt</span><span class="o">=</span><span class="kc">FALSE</span>,</td>
      </tr>
      <tr>
        <td id="L265" class="blob-num js-line-number" data-line-number="265"></td>
        <td id="LC265" class="blob-code js-file-line">        <span class="nv">printstats</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">NoCompOK</span><span class="o">=</span><span class="kc">TRUE</span>), <span class="nv">error</span><span class="o">=</span><span class="k">function</span>(<span class="nv">e</span>) <span class="kc">NA</span>)</td>
      </tr>
      <tr>
        <td id="L266" class="blob-num js-line-number" data-line-number="266"></td>
        <td id="LC266" class="blob-code js-file-line">      <span class="k">if</span>(is.list(<span class="nv">report.om</span>)<span class="o">==</span><span class="kc">FALSE</span>){</td>
      </tr>
      <tr>
        <td id="L267" class="blob-num js-line-number" data-line-number="267"></td>
        <td id="LC267" class="blob-code js-file-line">          warning(paste(<span class="s2">&quot;Necessary SS files missing from&quot;</span>, <span class="nv">scenario</span>, <span class="s2">&quot;replicate&quot;</span>, <span class="nv">rep</span>))</td>
      </tr>
      <tr>
        <td id="L268" class="blob-num js-line-number" data-line-number="268"></td>
        <td id="LC268" class="blob-code js-file-line">          <span class="nv">no.rep</span> <span class="o">&lt;-</span> <span class="nv">no.rep</span> <span class="o">+</span> <span class="m">1</span></td>
      </tr>
      <tr>
        <td id="L269" class="blob-num js-line-number" data-line-number="269"></td>
        <td id="LC269" class="blob-code js-file-line">          <span class="k">next</span></td>
      </tr>
      <tr>
        <td id="L270" class="blob-num js-line-number" data-line-number="270"></td>
        <td id="LC270" class="blob-code js-file-line">      }</td>
      </tr>
      <tr>
        <td id="L271" class="blob-num js-line-number" data-line-number="271"></td>
        <td id="LC271" class="blob-code js-file-line">        <span class="c1">## Grab the residuals for the indices</span></td>
      </tr>
      <tr>
        <td id="L272" class="blob-num js-line-number" data-line-number="272"></td>
        <td id="LC272" class="blob-code js-file-line">        <span class="nv">resids</span> <span class="o">&lt;-</span> log(<span class="nv">report.em</span><span class="k">$</span><span class="nv">cpue</span><span class="k">$</span><span class="nv">Obs</span>) <span class="o">-</span> log(<span class="nv">report.em</span><span class="k">$</span><span class="nv">cpue</span><span class="k">$</span><span class="nv">Exp</span>)</td>
      </tr>
      <tr>
        <td id="L273" class="blob-num js-line-number" data-line-number="273"></td>
        <td id="LC273" class="blob-code js-file-line">        <span class="nv">resids.long</span> <span class="o">&lt;-</span> <span class="kt">data.frame</span>(<span class="nv">report.em</span><span class="k">$</span><span class="nv">cpue</span>[,c(<span class="s2">&quot;FleetName&quot;</span>, <span class="s2">&quot;Yr&quot;</span>)], <span class="nv">resids</span>)</td>
      </tr>
      <tr>
        <td id="L274" class="blob-num js-line-number" data-line-number="274"></td>
        <td id="LC274" class="blob-code js-file-line">        <span class="nv">resids.list</span>[[<span class="nv">rep</span>]] <span class="o">&lt;-</span>  cbind(<span class="nv">scenario</span>, <span class="nv">rep</span>,</td>
      </tr>
      <tr>
        <td id="L275" class="blob-num js-line-number" data-line-number="275"></td>
        <td id="LC275" class="blob-code js-file-line">          reshape2<span class="k">::</span>dcast(<span class="nv">resids.long</span>, <span class="nv">FleetName</span><span class="k">~</span><span class="nv">Yr</span>, <span class="nv">value.var</span><span class="o">=</span><span class="s2">&quot;resids&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L276" class="blob-num js-line-number" data-line-number="276"></td>
        <td id="LC276" class="blob-code js-file-line">        <span class="c1">## Get scalars from the two models</span></td>
      </tr>
      <tr>
        <td id="L277" class="blob-num js-line-number" data-line-number="277"></td>
        <td id="LC277" class="blob-code js-file-line">        <span class="nv">scalar.om</span> <span class="o">&lt;-</span> get_results_scalar(<span class="nv">report.om</span>)</td>
      </tr>
      <tr>
        <td id="L278" class="blob-num js-line-number" data-line-number="278"></td>
        <td id="LC278" class="blob-code js-file-line">        names(<span class="nv">scalar.om</span>) <span class="o">&lt;-</span> paste0(names(<span class="nv">scalar.om</span>),<span class="s2">&quot;_om&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L279" class="blob-num js-line-number" data-line-number="279"></td>
        <td id="LC279" class="blob-code js-file-line">        <span class="nv">scalar.em</span> <span class="o">&lt;-</span> get_results_scalar(<span class="nv">report.em</span>)</td>
      </tr>
      <tr>
        <td id="L280" class="blob-num js-line-number" data-line-number="280"></td>
        <td id="LC280" class="blob-code js-file-line">        names(<span class="nv">scalar.em</span>) <span class="o">&lt;-</span> paste0(names(<span class="nv">scalar.em</span>),<span class="s2">&quot;_em&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L281" class="blob-num js-line-number" data-line-number="281"></td>
        <td id="LC281" class="blob-code js-file-line">        <span class="c1">## Get timeseires from the two</span></td>
      </tr>
      <tr>
        <td id="L282" class="blob-num js-line-number" data-line-number="282"></td>
        <td id="LC282" class="blob-code js-file-line">        <span class="nv">timeseries.om</span> <span class="o">&lt;-</span> get_results_timeseries(<span class="nv">report.om</span>)</td>
      </tr>
      <tr>
        <td id="L283" class="blob-num js-line-number" data-line-number="283"></td>
        <td id="LC283" class="blob-code js-file-line">        names(<span class="nv">timeseries.om</span>) <span class="o">&lt;-</span> paste0(names(<span class="nv">timeseries.om</span>),<span class="s2">&quot;_om&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L284" class="blob-num js-line-number" data-line-number="284"></td>
        <td id="LC284" class="blob-code js-file-line">        <span class="nv">timeseries.em</span> <span class="o">&lt;-</span> get_results_timeseries(<span class="nv">report.em</span>)</td>
      </tr>
      <tr>
        <td id="L285" class="blob-num js-line-number" data-line-number="285"></td>
        <td id="LC285" class="blob-code js-file-line">        names(<span class="nv">timeseries.em</span>) <span class="o">&lt;-</span> paste0(names(<span class="nv">timeseries.em</span>),<span class="s2">&quot;_em&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L286" class="blob-num js-line-number" data-line-number="286"></td>
        <td id="LC286" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L287" class="blob-num js-line-number" data-line-number="287"></td>
        <td id="LC287" class="blob-code js-file-line">        <span class="c1">## Combine them together and massage a bit</span></td>
      </tr>
      <tr>
        <td id="L288" class="blob-num js-line-number" data-line-number="288"></td>
        <td id="LC288" class="blob-code js-file-line">        <span class="nv">scalar</span> <span class="o">&lt;-</span> cbind(<span class="nv">scalar.om</span>, <span class="nv">scalar.em</span>, t(<span class="nv">bias</span>))</td>
      </tr>
      <tr>
        <td id="L289" class="blob-num js-line-number" data-line-number="289"></td>
        <td id="LC289" class="blob-code js-file-line">        <span class="nv">ts</span> <span class="o">&lt;-</span> cbind(<span class="nv">timeseries.om</span>, <span class="nv">timeseries.em</span>)</td>
      </tr>
      <tr>
        <td id="L290" class="blob-num js-line-number" data-line-number="290"></td>
        <td id="LC290" class="blob-code js-file-line">        <span class="nv">scalar</span><span class="k">$</span><span class="nv">scenario</span> <span class="o">&lt;-</span> <span class="nv">ts</span><span class="k">$</span><span class="nv">scenario</span> <span class="o">&lt;-</span> <span class="nv">scenario</span></td>
      </tr>
      <tr>
        <td id="L291" class="blob-num js-line-number" data-line-number="291"></td>
        <td id="LC291" class="blob-code js-file-line">        <span class="nv">scalar</span><span class="k">$</span><span class="nv">replicate</span> <span class="o">&lt;-</span> <span class="nv">ts</span><span class="k">$</span><span class="nv">replicate</span> <span class="o">&lt;-</span> <span class="nv">rep</span></td>
      </tr>
      <tr>
        <td id="L292" class="blob-num js-line-number" data-line-number="292"></td>
        <td id="LC292" class="blob-code js-file-line">        <span class="c1">## parse the scenarios into columns for plotting later</span></td>
      </tr>
      <tr>
        <td id="L293" class="blob-num js-line-number" data-line-number="293"></td>
        <td id="LC293" class="blob-code js-file-line">        <span class="nv">scenario.scalar</span> <span class="o">&lt;-</span></td>
      </tr>
      <tr>
        <td id="L294" class="blob-num js-line-number" data-line-number="294"></td>
        <td id="LC294" class="blob-code js-file-line">            <span class="kt">data.frame</span>(do.call(<span class="nv">rbind</span>, strsplit(as.character(<span class="nv">scalar</span><span class="k">$</span><span class="nv">scenario</span>),</td>
      </tr>
      <tr>
        <td id="L295" class="blob-num js-line-number" data-line-number="295"></td>
        <td id="LC295" class="blob-code js-file-line">                                               <span class="s2">&quot;-&quot;</span>)), <span class="nv">stringsAsFactors</span><span class="o">=</span><span class="kc">FALSE</span>)</td>
      </tr>
      <tr>
        <td id="L296" class="blob-num js-line-number" data-line-number="296"></td>
        <td id="LC296" class="blob-code js-file-line">        names(<span class="nv">scenario.scalar</span>) <span class="o">&lt;-</span></td>
      </tr>
      <tr>
        <td id="L297" class="blob-num js-line-number" data-line-number="297"></td>
        <td id="LC297" class="blob-code js-file-line">            c(substr(as.vector(as.character(</td>
      </tr>
      <tr>
        <td id="L298" class="blob-num js-line-number" data-line-number="298"></td>
        <td id="LC298" class="blob-code js-file-line">                <span class="nv">scenario.scalar</span>[<span class="m">1</span>,<span class="o">-</span>ncol(<span class="nv">scenario.scalar</span>)])), <span class="m">1</span>,<span class="m">1</span>) ,<span class="s2">&quot;species&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L299" class="blob-num js-line-number" data-line-number="299"></td>
        <td id="LC299" class="blob-code js-file-line">        <span class="nv">scenario.ts</span> <span class="o">&lt;-</span></td>
      </tr>
      <tr>
        <td id="L300" class="blob-num js-line-number" data-line-number="300"></td>
        <td id="LC300" class="blob-code js-file-line">            <span class="kt">data.frame</span>(do.call(<span class="nv">rbind</span>, strsplit(as.character(<span class="nv">ts</span><span class="k">$</span><span class="nv">scenario</span>), <span class="s2">&quot;-&quot;</span>)),</td>
      </tr>
      <tr>
        <td id="L301" class="blob-num js-line-number" data-line-number="301"></td>
        <td id="LC301" class="blob-code js-file-line">                       <span class="nv">row.names</span><span class="o">=</span>row.names(<span class="nv">ts</span>), <span class="nv">stringsAsFactors</span><span class="o">=</span><span class="kc">FALSE</span>)</td>
      </tr>
      <tr>
        <td id="L302" class="blob-num js-line-number" data-line-number="302"></td>
        <td id="LC302" class="blob-code js-file-line">        names(<span class="nv">scenario.ts</span>) <span class="o">&lt;-</span></td>
      </tr>
      <tr>
        <td id="L303" class="blob-num js-line-number" data-line-number="303"></td>
        <td id="LC303" class="blob-code js-file-line">            c(substr(as.vector(as.character(</td>
      </tr>
      <tr>
        <td id="L304" class="blob-num js-line-number" data-line-number="304"></td>
        <td id="LC304" class="blob-code js-file-line">                <span class="nv">scenario.ts</span>[<span class="m">1</span>,<span class="o">-</span>ncol(<span class="nv">scenario.ts</span>)])), <span class="m">1</span>,<span class="m">1</span>) ,<span class="s2">&quot;species&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L305" class="blob-num js-line-number" data-line-number="305"></td>
        <td id="LC305" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L306" class="blob-num js-line-number" data-line-number="306"></td>
        <td id="LC306" class="blob-code js-file-line">        <span class="nv">scalar</span> <span class="o">&lt;-</span> cbind(<span class="nv">scalar</span>, <span class="nv">scenario.scalar</span>)</td>
      </tr>
      <tr>
        <td id="L307" class="blob-num js-line-number" data-line-number="307"></td>
        <td id="LC307" class="blob-code js-file-line">        <span class="nv">ts</span> <span class="o">&lt;-</span> cbind(<span class="nv">ts</span>, <span class="nv">scenario.ts</span>)</td>
      </tr>
      <tr>
        <td id="L308" class="blob-num js-line-number" data-line-number="308"></td>
        <td id="LC308" class="blob-code js-file-line">        <span class="c1">## Other calcs</span></td>
      </tr>
      <tr>
        <td id="L309" class="blob-num js-line-number" data-line-number="309"></td>
        <td id="LC309" class="blob-code js-file-line">        <span class="nv">ts</span><span class="k">$</span><span class="nv">year</span> <span class="o">&lt;-</span> <span class="nv">ts</span><span class="k">$</span><span class="nv">Yr_om</span></td>
      </tr>
      <tr>
        <td id="L310" class="blob-num js-line-number" data-line-number="310"></td>
        <td id="LC310" class="blob-code js-file-line">        <span class="nv">ts</span><span class="k">$</span><span class="nv">Yr_om</span> <span class="o">&lt;-</span> <span class="kc">NULL</span></td>
      </tr>
      <tr>
        <td id="L311" class="blob-num js-line-number" data-line-number="311"></td>
        <td id="LC311" class="blob-code js-file-line">        <span class="nv">ts</span><span class="k">$</span><span class="nv">Yr_em</span> <span class="o">&lt;-</span> <span class="kc">NULL</span></td>
      </tr>
      <tr>
        <td id="L312" class="blob-num js-line-number" data-line-number="312"></td>
        <td id="LC312" class="blob-code js-file-line">        <span class="nv">scalar</span><span class="k">$</span><span class="nv">max_grad</span> <span class="o">&lt;-</span> <span class="nv">scalar</span><span class="k">$</span><span class="nv">max_grad_em</span></td>
      </tr>
      <tr>
        <td id="L313" class="blob-num js-line-number" data-line-number="313"></td>
        <td id="LC313" class="blob-code js-file-line">        <span class="nv">ignore.cols</span> <span class="o">&lt;-</span> which(names(<span class="nv">scalar</span>) <span class="o">%in%</span> c(<span class="s2">&quot;max_grad_om&quot;</span>, <span class="s2">&quot;max_grad_em&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L314" class="blob-num js-line-number" data-line-number="314"></td>
        <td id="LC314" class="blob-code js-file-line">        <span class="nv">scalar</span> <span class="o">&lt;-</span> <span class="nv">scalar</span>[ , <span class="o">-</span><span class="nv">ignore.cols</span>]</td>
      </tr>
      <tr>
        <td id="L315" class="blob-num js-line-number" data-line-number="315"></td>
        <td id="LC315" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L316" class="blob-num js-line-number" data-line-number="316"></td>
        <td id="LC316" class="blob-code js-file-line">        <span class="c1">## Also get the version and runtime, as checks</span></td>
      </tr>
      <tr>
        <td id="L317" class="blob-num js-line-number" data-line-number="317"></td>
        <td id="LC317" class="blob-code js-file-line">        <span class="nv">temp</span> <span class="o">&lt;-</span> readLines(<span class="nv">con</span><span class="o">=</span>paste0(<span class="nv">rep</span>,<span class="s2">&quot;/em/Report.sso&quot;</span>), <span class="nv">n</span><span class="o">=</span><span class="m">10</span>)</td>
      </tr>
      <tr>
        <td id="L318" class="blob-num js-line-number" data-line-number="318"></td>
        <td id="LC318" class="blob-code js-file-line">        <span class="nv">scalar</span><span class="k">$</span><span class="nv">version</span> <span class="o">&lt;-</span> <span class="nv">temp</span>[<span class="m">1</span>]</td>
      </tr>
      <tr>
        <td id="L319" class="blob-num js-line-number" data-line-number="319"></td>
        <td id="LC319" class="blob-code js-file-line">        <span class="nv">scalar</span><span class="k">$</span><span class="nv">RunTime</span> <span class="o">&lt;-</span> calculate_runtime(<span class="nv">temp</span>[<span class="m">4</span>],<span class="nv">temp</span>[<span class="m">5</span>])</td>
      </tr>
      <tr>
        <td id="L320" class="blob-num js-line-number" data-line-number="320"></td>
        <td id="LC320" class="blob-code js-file-line">        <span class="nv">scalar</span><span class="k">$</span><span class="nv">hessian</span> <span class="o">&lt;-</span> file.exists(paste0(<span class="nv">rep</span>,<span class="s2">&quot;/em/admodel.cov&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L321" class="blob-num js-line-number" data-line-number="321"></td>
        <td id="LC321" class="blob-code js-file-line">        <span class="c1">## Write them to file in the scenario folder</span></td>
      </tr>
      <tr>
        <td id="L322" class="blob-num js-line-number" data-line-number="322"></td>
        <td id="LC322" class="blob-code js-file-line">        <span class="nv">scalar.exists</span> <span class="o">&lt;-</span> file.exists(<span class="nv">scalar.file</span>)</td>
      </tr>
      <tr>
        <td id="L323" class="blob-num js-line-number" data-line-number="323"></td>
        <td id="LC323" class="blob-code js-file-line">        write.table(<span class="nv">x</span><span class="o">=</span><span class="nv">scalar</span>, <span class="nv">file</span><span class="o">=</span><span class="nv">scalar.file</span>, <span class="nv">append</span><span class="o">=</span><span class="nv">scalar.exists</span>,</td>
      </tr>
      <tr>
        <td id="L324" class="blob-num js-line-number" data-line-number="324"></td>
        <td id="LC324" class="blob-code js-file-line">                    <span class="nv">col.names</span><span class="o">=</span><span class="o">!</span><span class="nv">scalar.exists</span>, <span class="nv">row.names</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">sep</span><span class="o">=</span><span class="s2">&quot;,&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L325" class="blob-num js-line-number" data-line-number="325"></td>
        <td id="LC325" class="blob-code js-file-line">        <span class="nv">ts.exists</span> <span class="o">&lt;-</span> file.exists(<span class="nv">ts.file</span>)</td>
      </tr>
      <tr>
        <td id="L326" class="blob-num js-line-number" data-line-number="326"></td>
        <td id="LC326" class="blob-code js-file-line">        write.table(<span class="nv">x</span><span class="o">=</span><span class="nv">ts</span>, <span class="nv">file</span><span class="o">=</span><span class="nv">ts.file</span>, <span class="nv">append</span><span class="o">=</span><span class="nv">ts.exists</span>,</td>
      </tr>
      <tr>
        <td id="L327" class="blob-num js-line-number" data-line-number="327"></td>
        <td id="LC327" class="blob-code js-file-line">                    <span class="nv">col.names</span><span class="o">=</span><span class="o">!</span><span class="nv">ts.exists</span>, <span class="nv">row.names</span><span class="o">=</span><span class="kc">FALSE</span>, <span class="nv">sep</span><span class="o">=</span><span class="s2">&quot;,&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L328" class="blob-num js-line-number" data-line-number="328"></td>
        <td id="LC328" class="blob-code js-file-line">    }</td>
      </tr>
      <tr>
        <td id="L329" class="blob-num js-line-number" data-line-number="329"></td>
        <td id="LC329" class="blob-code js-file-line">    <span class="c1">## Create df for the residuals</span></td>
      </tr>
      <tr>
        <td id="L330" class="blob-num js-line-number" data-line-number="330"></td>
        <td id="LC330" class="blob-code js-file-line">    <span class="nv">resids</span> <span class="o">&lt;-</span> do.call(<span class="nv">rbind</span>, <span class="nv">resids.list</span>)</td>
      </tr>
      <tr>
        <td id="L331" class="blob-num js-line-number" data-line-number="331"></td>
        <td id="LC331" class="blob-code js-file-line">    write.table(<span class="nv">x</span><span class="o">=</span><span class="nv">resids</span>, <span class="nv">file</span><span class="o">=</span><span class="nv">resids.file</span>, <span class="nv">sep</span><span class="o">=</span><span class="s2">&quot;,&quot;</span>, <span class="nv">row.names</span><span class="o">=</span><span class="kc">FALSE</span>)</td>
      </tr>
      <tr>
        <td id="L332" class="blob-num js-line-number" data-line-number="332"></td>
        <td id="LC332" class="blob-code js-file-line">    <span class="c1">## End of loops for extracting results</span></td>
      </tr>
      <tr>
        <td id="L333" class="blob-num js-line-number" data-line-number="333"></td>
        <td id="LC333" class="blob-code js-file-line">    <span class="c1">## outputs number of successful replicates</span></td>
      </tr>
      <tr>
        <td id="L334" class="blob-num js-line-number" data-line-number="334"></td>
        <td id="LC334" class="blob-code js-file-line">    message(paste0(<span class="s2">&quot;Result files created for &quot;</span>,<span class="nv">scenario</span>, <span class="s2">&quot; with &quot;</span>,</td>
      </tr>
      <tr>
        <td id="L335" class="blob-num js-line-number" data-line-number="335"></td>
        <td id="LC335" class="blob-code js-file-line">                 length(<span class="nv">reps.dirs</span>) <span class="o">-</span> <span class="nv">no.rep</span>, <span class="s2">&quot; replicates&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L336" class="blob-num js-line-number" data-line-number="336"></td>
        <td id="LC336" class="blob-code js-file-line">}</td>
      </tr>
      <tr>
        <td id="L337" class="blob-num js-line-number" data-line-number="337"></td>
        <td id="LC337" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L338" class="blob-num js-line-number" data-line-number="338"></td>
        <td id="LC338" class="blob-code js-file-line"><span class="c1">#' Extract time series from a model run.</span></td>
      </tr>
      <tr>
        <td id="L339" class="blob-num js-line-number" data-line-number="339"></td>
        <td id="LC339" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L340" class="blob-num js-line-number" data-line-number="340"></td>
        <td id="LC340" class="blob-code js-file-line"><span class="c1">#' Extract time series from an \code{SS_output} list from a model run.</span></td>
      </tr>
      <tr>
        <td id="L341" class="blob-num js-line-number" data-line-number="341"></td>
        <td id="LC341" class="blob-code js-file-line"><span class="c1">#' Returns a data.frame of the results for SSB, recruitment and effort by year.</span></td>
      </tr>
      <tr>
        <td id="L342" class="blob-num js-line-number" data-line-number="342"></td>
        <td id="LC342" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L343" class="blob-num js-line-number" data-line-number="343"></td>
        <td id="LC343" class="blob-code js-file-line"><span class="c1">#' @param report.file An \code{SS_output} list for a model (operating model or estimation model).</span></td>
      </tr>
      <tr>
        <td id="L344" class="blob-num js-line-number" data-line-number="344"></td>
        <td id="LC344" class="blob-code js-file-line"><span class="c1">#' @export</span></td>
      </tr>
      <tr>
        <td id="L345" class="blob-num js-line-number" data-line-number="345"></td>
        <td id="LC345" class="blob-code js-file-line"><span class="c1">#' @family get-results</span></td>
      </tr>
      <tr>
        <td id="L346" class="blob-num js-line-number" data-line-number="346"></td>
        <td id="LC346" class="blob-code js-file-line"><span class="c1">#' @author Cole Monnahan</span></td>
      </tr>
      <tr>
        <td id="L347" class="blob-num js-line-number" data-line-number="347"></td>
        <td id="LC347" class="blob-code js-file-line"><span class="nf">get_results_timeseries</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">report.file</span>){</td>
      </tr>
      <tr>
        <td id="L348" class="blob-num js-line-number" data-line-number="348"></td>
        <td id="LC348" class="blob-code js-file-line">    <span class="nv">years</span> <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">startyr</span><span class="k">:</span>(<span class="nv">report.file</span><span class="k">$</span><span class="nv">endyr</span> <span class="o">+</span></td>
      </tr>
      <tr>
        <td id="L349" class="blob-num js-line-number" data-line-number="349"></td>
        <td id="LC349" class="blob-code js-file-line">                                  ifelse(is.na(<span class="nv">report.file</span><span class="k">$</span><span class="nv">nforecastyears</span>) <span class="o">==</span></td>
      </tr>
      <tr>
        <td id="L350" class="blob-num js-line-number" data-line-number="350"></td>
        <td id="LC350" class="blob-code js-file-line">                                      <span class="kc">TRUE</span>, <span class="m">0</span>,</td>
      </tr>
      <tr>
        <td id="L351" class="blob-num js-line-number" data-line-number="351"></td>
        <td id="LC351" class="blob-code js-file-line">                                         <span class="nv">report.file</span><span class="k">$</span><span class="nv">nforecastyears</span>))</td>
      </tr>
      <tr>
        <td id="L352" class="blob-num js-line-number" data-line-number="352"></td>
        <td id="LC352" class="blob-code js-file-line">    <span class="nv">xx</span> <span class="o">&lt;-</span> subset(<span class="nv">report.file</span><span class="k">$</span><span class="nv">timeseries</span>,</td>
      </tr>
      <tr>
        <td id="L353" class="blob-num js-line-number" data-line-number="353"></td>
        <td id="LC353" class="blob-code js-file-line">                 <span class="nv">select</span><span class="o">=</span>c(<span class="s2">&quot;Yr&quot;</span>,<span class="s2">&quot;SpawnBio&quot;</span>, <span class="s2">&quot;Recruit_0&quot;</span>, <span class="s2">&quot;F:_1&quot;</span>))</td>
      </tr>
      <tr>
        <td id="L354" class="blob-num js-line-number" data-line-number="354"></td>
        <td id="LC354" class="blob-code js-file-line">    <span class="nv">xx</span> <span class="o">&lt;-</span> <span class="nv">xx</span>[<span class="nv">xx</span><span class="k">$</span><span class="nv">Yr</span> <span class="o">%in%</span> <span class="nv">years</span>,]</td>
      </tr>
      <tr>
        <td id="L355" class="blob-num js-line-number" data-line-number="355"></td>
        <td id="LC355" class="blob-code js-file-line">    names(<span class="nv">xx</span>) <span class="o">&lt;-</span> gsub(<span class="s2">&quot;:_1&quot;</span>,<span class="s2">&quot;&quot;</span>, names(<span class="nv">xx</span>))</td>
      </tr>
      <tr>
        <td id="L356" class="blob-num js-line-number" data-line-number="356"></td>
        <td id="LC356" class="blob-code js-file-line">    <span class="c1">## create final data.frame</span></td>
      </tr>
      <tr>
        <td id="L357" class="blob-num js-line-number" data-line-number="357"></td>
        <td id="LC357" class="blob-code js-file-line">    <span class="nv">df</span> <span class="o">&lt;-</span> <span class="kt">data.frame</span>(<span class="nv">xx</span>, <span class="nv">row.names</span><span class="o">=</span><span class="kc">NULL</span> )</td>
      </tr>
      <tr>
        <td id="L358" class="blob-num js-line-number" data-line-number="358"></td>
        <td id="LC358" class="blob-code js-file-line">    <span class="k">return</span>(<span class="k">invisible</span>(<span class="nv">df</span>))</td>
      </tr>
      <tr>
        <td id="L359" class="blob-num js-line-number" data-line-number="359"></td>
        <td id="LC359" class="blob-code js-file-line">}</td>
      </tr>
      <tr>
        <td id="L360" class="blob-num js-line-number" data-line-number="360"></td>
        <td id="LC360" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L361" class="blob-num js-line-number" data-line-number="361"></td>
        <td id="LC361" class="blob-code js-file-line"><span class="c1">#' Extract scalar quantities from a model run.</span></td>
      </tr>
      <tr>
        <td id="L362" class="blob-num js-line-number" data-line-number="362"></td>
        <td id="LC362" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L363" class="blob-num js-line-number" data-line-number="363"></td>
        <td id="LC363" class="blob-code js-file-line"><span class="c1">#' Extract scalar quantities from an \code{SS_output} list from a model run.</span></td>
      </tr>
      <tr>
        <td id="L364" class="blob-num js-line-number" data-line-number="364"></td>
        <td id="LC364" class="blob-code js-file-line"><span class="c1">#' Returns a data.frame of the results (a single row) which can be rbinded later.</span></td>
      </tr>
      <tr>
        <td id="L365" class="blob-num js-line-number" data-line-number="365"></td>
        <td id="LC365" class="blob-code js-file-line"><span class="c1">#' @param report.file An SS_output list for a model (operating model or estimation model).</span></td>
      </tr>
      <tr>
        <td id="L366" class="blob-num js-line-number" data-line-number="366"></td>
        <td id="LC366" class="blob-code js-file-line"><span class="c1">#' @family get-results</span></td>
      </tr>
      <tr>
        <td id="L367" class="blob-num js-line-number" data-line-number="367"></td>
        <td id="LC367" class="blob-code js-file-line"><span class="c1">#' @export</span></td>
      </tr>
      <tr>
        <td id="L368" class="blob-num js-line-number" data-line-number="368"></td>
        <td id="LC368" class="blob-code js-file-line"><span class="c1">#' @author Cole Monnahan; updated by Merrill Rudd to include additional</span></td>
      </tr>
      <tr>
        <td id="L369" class="blob-num js-line-number" data-line-number="369"></td>
        <td id="LC369" class="blob-code js-file-line"><span class="c1">#'   likelihoods</span></td>
      </tr>
      <tr>
        <td id="L370" class="blob-num js-line-number" data-line-number="370"></td>
        <td id="LC370" class="blob-code js-file-line"><span class="nf">get_results_scalar</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">report.file</span>){</td>
      </tr>
      <tr>
        <td id="L371" class="blob-num js-line-number" data-line-number="371"></td>
        <td id="LC371" class="blob-code js-file-line">    <span class="nv">der</span> <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">derived_quants</span></td>
      </tr>
      <tr>
        <td id="L372" class="blob-num js-line-number" data-line-number="372"></td>
        <td id="LC372" class="blob-code js-file-line">    <span class="nv">SSB_MSY</span> <span class="o">&lt;-</span>  <span class="nv">der</span>[which(<span class="nv">der</span><span class="k">$</span><span class="nv">LABEL</span><span class="o">==</span><span class="s2">&quot;SSB_MSY&quot;</span>),]<span class="k">$</span><span class="nv">Value</span></td>
      </tr>
      <tr>
        <td id="L373" class="blob-num js-line-number" data-line-number="373"></td>
        <td id="LC373" class="blob-code js-file-line">    <span class="nv">TotYield_MSY</span> <span class="o">&lt;-</span>  <span class="nv">der</span>[which(<span class="nv">der</span><span class="k">$</span><span class="nv">LABEL</span><span class="o">==</span><span class="s2">&quot;TotYield_MSY&quot;</span>),]<span class="k">$</span><span class="nv">Value</span></td>
      </tr>
      <tr>
        <td id="L374" class="blob-num js-line-number" data-line-number="374"></td>
        <td id="LC374" class="blob-code js-file-line">    <span class="nv">SSB_Unfished</span> <span class="o">&lt;-</span>  <span class="nv">der</span>[which(<span class="nv">der</span><span class="k">$</span><span class="nv">LABEL</span><span class="o">==</span><span class="s2">&quot;SSB_Unfished&quot;</span>),]<span class="k">$</span><span class="nv">Value</span></td>
      </tr>
      <tr>
        <td id="L375" class="blob-num js-line-number" data-line-number="375"></td>
        <td id="LC375" class="blob-code js-file-line">    <span class="nv">Catch_endyear</span> <span class="o">&lt;-</span></td>
      </tr>
      <tr>
        <td id="L376" class="blob-num js-line-number" data-line-number="376"></td>
        <td id="LC376" class="blob-code js-file-line">        rev(<span class="nv">report.file</span><span class="k">$</span><span class="nv">timeseries</span>[,grep(<span class="s2">&quot;dead<span class="sc">\\</span>(B<span class="sc">\\</span>)&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L377" class="blob-num js-line-number" data-line-number="377"></td>
        <td id="LC377" class="blob-code js-file-line">          names(<span class="nv">report.file</span><span class="k">$</span><span class="nv">timeseries</span>))])[<span class="m">1</span>]</td>
      </tr>
      <tr>
        <td id="L378" class="blob-num js-line-number" data-line-number="378"></td>
        <td id="LC378" class="blob-code js-file-line">    <span class="nv">pars</span> <span class="o">&lt;-</span> <span class="kt">data.frame</span>(t(<span class="nv">report.file</span><span class="k">$</span><span class="nv">parameters</span><span class="k">$</span><span class="nv">Value</span>))</td>
      </tr>
      <tr>
        <td id="L379" class="blob-num js-line-number" data-line-number="379"></td>
        <td id="LC379" class="blob-code js-file-line">    names(<span class="nv">pars</span>) <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">parameters</span><span class="k">$</span><span class="nv">Label</span></td>
      </tr>
      <tr>
        <td id="L380" class="blob-num js-line-number" data-line-number="380"></td>
        <td id="LC380" class="blob-code js-file-line">    <span class="c1">## Remove the recruitment devs and efforts as these are in the ts file</span></td>
      </tr>
      <tr>
        <td id="L381" class="blob-num js-line-number" data-line-number="381"></td>
        <td id="LC381" class="blob-code js-file-line">    <span class="nv">recdev.index</span> <span class="o">&lt;-</span> grep(<span class="s2">&quot;MAIN_&quot;</span>, toupper(names(<span class="nv">pars</span>)), <span class="nv">fixed</span><span class="o">=</span><span class="kc">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L382" class="blob-num js-line-number" data-line-number="382"></td>
        <td id="LC382" class="blob-code js-file-line">    <span class="k">if</span>(length(<span class="nv">recdev.index</span>)<span class="o">&gt;</span><span class="m">0</span>) <span class="nv">pars</span> <span class="o">&lt;-</span> <span class="nv">pars</span>[,<span class="o">-</span><span class="nv">recdev.index</span>]</td>
      </tr>
      <tr>
        <td id="L383" class="blob-num js-line-number" data-line-number="383"></td>
        <td id="LC383" class="blob-code js-file-line">    <span class="nv">effort.index</span> <span class="o">&lt;-</span> grep(<span class="s2">&quot;F_FLEET_&quot;</span>, toupper(names(<span class="nv">pars</span>)), <span class="nv">fixed</span><span class="o">=</span><span class="kc">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L384" class="blob-num js-line-number" data-line-number="384"></td>
        <td id="LC384" class="blob-code js-file-line">    <span class="k">if</span>(length(<span class="nv">effort.index</span>)<span class="o">&gt;</span><span class="m">0</span>) <span class="nv">pars</span> <span class="o">&lt;-</span> <span class="nv">pars</span>[,<span class="o">-</span><span class="nv">effort.index</span>]</td>
      </tr>
      <tr>
        <td id="L385" class="blob-num js-line-number" data-line-number="385"></td>
        <td id="LC385" class="blob-code js-file-line">    names(<span class="nv">pars</span>) <span class="o">&lt;-</span> gsub(<span class="s2">&quot;<span class="sc">\\</span>(&quot;</span>,<span class="s2">&quot;_&quot;</span>, names(<span class="nv">pars</span>))</td>
      </tr>
      <tr>
        <td id="L386" class="blob-num js-line-number" data-line-number="386"></td>
        <td id="LC386" class="blob-code js-file-line">    names(<span class="nv">pars</span>) <span class="o">&lt;-</span> gsub(<span class="s2">&quot;<span class="sc">\\</span>)&quot;</span>,<span class="s2">&quot;&quot;</span>, names(<span class="nv">pars</span>))</td>
      </tr>
      <tr>
        <td id="L387" class="blob-num js-line-number" data-line-number="387"></td>
        <td id="LC387" class="blob-code js-file-line">    <span class="nv">max_grad</span> <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">maximum_gradient_component</span></td>
      </tr>
      <tr>
        <td id="L388" class="blob-num js-line-number" data-line-number="388"></td>
        <td id="LC388" class="blob-code js-file-line">    <span class="nv">depletion</span> <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">current_depletion</span></td>
      </tr>
      <tr>
        <td id="L389" class="blob-num js-line-number" data-line-number="389"></td>
        <td id="LC389" class="blob-code js-file-line">    <span class="nv">NLL_vec</span> <span class="o">&lt;-</span> get_nll_components(<span class="nv">report.file</span>)</td>
      </tr>
      <tr>
        <td id="L390" class="blob-num js-line-number" data-line-number="390"></td>
        <td id="LC390" class="blob-code js-file-line">    <span class="c1">## get the number of params on bounds from the warning.sso file, useful for</span></td>
      </tr>
      <tr>
        <td id="L391" class="blob-num js-line-number" data-line-number="391"></td>
        <td id="LC391" class="blob-code js-file-line">    <span class="c1">## checking convergence issues</span></td>
      </tr>
      <tr>
        <td id="L392" class="blob-num js-line-number" data-line-number="392"></td>
        <td id="LC392" class="blob-code js-file-line">    <span class="nv">warn</span> <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">warnings</span></td>
      </tr>
      <tr>
        <td id="L393" class="blob-num js-line-number" data-line-number="393"></td>
        <td id="LC393" class="blob-code js-file-line">    <span class="nv">warn.line</span> <span class="o">&lt;-</span> grep(<span class="s2">&quot;Number_of_active_parameters&quot;</span>, <span class="nv">warn</span>, <span class="nv">fixed</span><span class="o">=</span><span class="kc">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L394" class="blob-num js-line-number" data-line-number="394"></td>
        <td id="LC394" class="blob-code js-file-line">    <span class="nv">params_on_bound</span> <span class="o">&lt;-</span></td>
      </tr>
      <tr>
        <td id="L395" class="blob-num js-line-number" data-line-number="395"></td>
        <td id="LC395" class="blob-code js-file-line">        ifelse(length(<span class="nv">warn.line</span>)<span class="o">==</span><span class="m">1</span>,</td>
      </tr>
      <tr>
        <td id="L396" class="blob-num js-line-number" data-line-number="396"></td>
        <td id="LC396" class="blob-code js-file-line">          as.numeric(strsplit(<span class="nv">warn</span>[<span class="nv">warn.line</span>], <span class="nv">split</span><span class="o">=</span><span class="s2">&quot;:&quot;</span>)[[<span class="m">1</span>]][<span class="m">2</span>]), <span class="kc">NA</span>)</td>
      </tr>
      <tr>
        <td id="L397" class="blob-num js-line-number" data-line-number="397"></td>
        <td id="LC397" class="blob-code js-file-line">    <span class="c1">## Combine into final df and return it</span></td>
      </tr>
      <tr>
        <td id="L398" class="blob-num js-line-number" data-line-number="398"></td>
        <td id="LC398" class="blob-code js-file-line">    <span class="nv">df</span> <span class="o">&lt;-</span> cbind(<span class="nv">SSB_MSY</span>, <span class="nv">TotYield_MSY</span>, <span class="nv">SSB_Unfished</span>, <span class="nv">max_grad</span>, <span class="nv">depletion</span>,</td>
      </tr>
      <tr>
        <td id="L399" class="blob-num js-line-number" data-line-number="399"></td>
        <td id="LC399" class="blob-code js-file-line">                <span class="nv">params_on_bound</span>, <span class="nv">pars</span>, <span class="nv">Catch_endyear</span>, t(<span class="nv">NLL_vec</span>))</td>
      </tr>
      <tr>
        <td id="L400" class="blob-num js-line-number" data-line-number="400"></td>
        <td id="LC400" class="blob-code js-file-line">    <span class="k">return</span>(<span class="k">invisible</span>(<span class="nv">df</span>))</td>
      </tr>
      <tr>
        <td id="L401" class="blob-num js-line-number" data-line-number="401"></td>
        <td id="LC401" class="blob-code js-file-line">}</td>
      </tr>
      <tr>
        <td id="L402" class="blob-num js-line-number" data-line-number="402"></td>
        <td id="LC402" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L403" class="blob-num js-line-number" data-line-number="403"></td>
        <td id="LC403" class="blob-code js-file-line"><span class="c1">#' Get negative log likelihood (NLL) values from a report file list</span></td>
      </tr>
      <tr>
        <td id="L404" class="blob-num js-line-number" data-line-number="404"></td>
        <td id="LC404" class="blob-code js-file-line"><span class="c1">#'</span></td>
      </tr>
      <tr>
        <td id="L405" class="blob-num js-line-number" data-line-number="405"></td>
        <td id="LC405" class="blob-code js-file-line"><span class="c1">#' @param report.file An SS_output list for a model</span></td>
      </tr>
      <tr>
        <td id="L406" class="blob-num js-line-number" data-line-number="406"></td>
        <td id="LC406" class="blob-code js-file-line"><span class="c1">#' @author Merrill Rudd</span></td>
      </tr>
      <tr>
        <td id="L407" class="blob-num js-line-number" data-line-number="407"></td>
        <td id="LC407" class="blob-code js-file-line"><span class="nf">get_nll_components</span> <span class="o">&lt;-</span> <span class="k">function</span>(<span class="nv">report.file</span>){</td>
      </tr>
      <tr>
        <td id="L408" class="blob-num js-line-number" data-line-number="408"></td>
        <td id="LC408" class="blob-code js-file-line">    <span class="c1">## Possible likelihood components from SS3.tpl</span></td>
      </tr>
      <tr>
        <td id="L409" class="blob-num js-line-number" data-line-number="409"></td>
        <td id="LC409" class="blob-code js-file-line">    <span class="nv">NLL_components</span> <span class="o">&lt;-</span> c(<span class="s2">&quot;TOTAL&quot;</span>, <span class="s2">&quot;Catch&quot;</span>, <span class="s2">&quot;Equil_catch&quot;</span>, <span class="s2">&quot;Survey&quot;</span>, <span class="s2">&quot;Discard&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L410" class="blob-num js-line-number" data-line-number="410"></td>
        <td id="LC410" class="blob-code js-file-line">      <span class="s2">&quot;Mean_body_wt&quot;</span>, <span class="s2">&quot;Length_comp&quot;</span>, <span class="s2">&quot;Age_comp&quot;</span>, <span class="s2">&quot;Size_at_age&quot;</span>, <span class="s2">&quot;SizeFreq&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L411" class="blob-num js-line-number" data-line-number="411"></td>
        <td id="LC411" class="blob-code js-file-line">      <span class="s2">&quot;Morphcomp&quot;</span>, <span class="s2">&quot;Tag_comp&quot;</span>, <span class="s2">&quot;Tag_negbin&quot;</span>, <span class="s2">&quot;Recruitment&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L412" class="blob-num js-line-number" data-line-number="412"></td>
        <td id="LC412" class="blob-code js-file-line">      <span class="s2">&quot;Forecast_Recruitment&quot;</span>, <span class="s2">&quot;Parm_priors&quot;</span>, <span class="s2">&quot;Parm_softbounds&quot;</span>, <span class="s2">&quot;Parm_devs&quot;</span>,</td>
      </tr>
      <tr>
        <td id="L413" class="blob-num js-line-number" data-line-number="413"></td>
        <td id="LC413" class="blob-code js-file-line">      <span class="s2">&quot;Crash_Pen&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L414" class="blob-num js-line-number" data-line-number="414"></td>
        <td id="LC414" class="blob-code js-file-line">    <span class="nv">NLL_names</span> <span class="o">&lt;-</span> paste(<span class="s2">&quot;NLL&quot;</span>, <span class="nv">NLL_components</span>, <span class="nv">sep</span><span class="o">=</span><span class="s2">&quot;_&quot;</span>)</td>
      </tr>
      <tr>
        <td id="L415" class="blob-num js-line-number" data-line-number="415"></td>
        <td id="LC415" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L416" class="blob-num js-line-number" data-line-number="416"></td>
        <td id="LC416" class="blob-code js-file-line">    <span class="nv">like_mat</span> <span class="o">&lt;-</span> <span class="nv">report.file</span><span class="k">$</span><span class="nv">likelihoods_used</span></td>
      </tr>
      <tr>
        <td id="L417" class="blob-num js-line-number" data-line-number="417"></td>
        <td id="LC417" class="blob-code js-file-line">    <span class="nv">vec</span> <span class="o">&lt;-</span> sapply(<span class="nv">NLL_components</span>, <span class="k">function</span>(<span class="nv">x</span>)</td>
      </tr>
      <tr>
        <td id="L418" class="blob-num js-line-number" data-line-number="418"></td>
        <td id="LC418" class="blob-code js-file-line">      ifelse(length(<span class="nv">like_mat</span>[which(rownames(<span class="nv">like_mat</span>)<span class="o">==</span><span class="nv">x</span>), <span class="m">1</span>])<span class="o">==</span><span class="m">0</span>,</td>
      </tr>
      <tr>
        <td id="L419" class="blob-num js-line-number" data-line-number="419"></td>
        <td id="LC419" class="blob-code js-file-line">                <span class="kc">NA</span>, <span class="nv">like_mat</span>[which(rownames(<span class="nv">like_mat</span>)<span class="o">==</span><span class="nv">x</span>), <span class="m">1</span>]))</td>
      </tr>
      <tr>
        <td id="L420" class="blob-num js-line-number" data-line-number="420"></td>
        <td id="LC420" class="blob-code js-file-line">    names(<span class="nv">vec</span>) <span class="o">&lt;-</span> <span class="nv">NLL_names</span></td>
      </tr>
      <tr>
        <td id="L421" class="blob-num js-line-number" data-line-number="421"></td>
        <td id="LC421" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L422" class="blob-num js-line-number" data-line-number="422"></td>
        <td id="LC422" class="blob-code js-file-line">    <span class="k">return</span>(<span class="nv">vec</span>)</td>
      </tr>
      <tr>
        <td id="L423" class="blob-num js-line-number" data-line-number="423"></td>
        <td id="LC423" class="blob-code js-file-line">}</td>
      </tr>
</table>

  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer" role="contentinfo">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="https://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.06174s from github-fe135-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-suggester-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents js-suggester-field" placeholder=""></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x flash-close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-15f10010d7ea9e4d5b9f20455abfb143a279c44fe8decefa4ab0af3a11c2e0fe.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-2fe20e6e44d2b80e9c800a1164325f4e6da5015a624e73f224f3dd869bcd4dfc.js" type="text/javascript"></script>
      
      
  </body>
</html>


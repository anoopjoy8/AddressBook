  <nav class="navbar navbar-inverse navbar-expand-sm cnav">
    <div class="container-fluid">
      <div class="navbar-header">
        <i class="fas fa-address-book fa-4x fnt"> <span class="navsub-title"></span></i>
      </div>
      <div class="navsub-title">ADDRESS BOOK</div>
      <ul class="nav navbar-nav navbar-right ">
        <li class="nav-item nav1">
          <a href="sign-up.cfm"><i class="fas fa-user navsub"> <span class="text1">Signup</span></i></a>
        </li>
      <cfif structKeyExists(session, 'dataLoggedIn')> 
        <li class="nav-item nav2">
          <a href="components/authentication.cfc?method=logoutMethod"><i class="fas fa-sign-in-alt navsub"> <span class="text1">Logout</span></i></a>
        </li>
      <cfelse>
        <li class="nav-item nav2">
          <a href=""><i class="fas fa-sign-in-alt navsub"> <span class="text1">Login</span></i></a>
        </li>
      </cfif>
      </ul>
    </div>
  </nav>
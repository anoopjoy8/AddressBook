<cfcomponent persistent="true" table="address_users">
      <cfproperty name="id" column = "id" generator="increment">
      <cfproperty name="name">
      <cfproperty name="user_name">
      <cfproperty name="email">
      <cfproperty name="password">
  </cfcomponent>
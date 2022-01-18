<cfcomponent persistent="true" table="address_contacts" entityname="giggidy">
  <cfproperty name="id" column = "id" generator="increment">
      <cfproperty name="fname">
      <cfproperty name="sname">
      <cfproperty name="address">
      <cfproperty name="email">
      <cfproperty name="phone">
      <cfproperty name="gender">
      <cfproperty name="dob">
      <cfproperty name="photo">
      <cfproperty name="street_name">
  </cfcomponent>
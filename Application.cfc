component {
    this.name = "Addressbook";
    this.datasource = "AppDataSource";
    this.appBasePath = getDirectoryFromPath(getCurrentTemplatePath());
    this.sessionManagement = true;

    function onApplicationStart() {
        application.config="xyz";
    }

 }
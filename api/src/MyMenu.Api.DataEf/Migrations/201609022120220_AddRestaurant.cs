namespace MyMenu.Api.DataEf.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddRestaurant : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Restaurants",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Address = c.String(maxLength: 256),
                        Description = c.String(maxLength: 1024),
                        Email = c.String(maxLength: 256),
                        Latitude = c.Decimal(nullable: false, precision: 11, scale: 6),
                        Longitude = c.Decimal(nullable: false, precision: 11, scale: 6),
                        Name = c.String(maxLength: 256),
                        PhoneNumber = c.String(maxLength: 256),
                        Photo = c.String(maxLength: 256),
                        Schedule = c.String(maxLength: 256),
                        Type = c.Int(nullable: false),
                        Username = c.String(maxLength: 256),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Restaurants");
        }
    }
}

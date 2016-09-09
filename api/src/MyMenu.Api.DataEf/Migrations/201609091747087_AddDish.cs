namespace MyMenu.Api.DataEf.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddDish : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Dishes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Ative = c.Boolean(nullable: false),
                        Date = c.DateTime(),
                        DayOfWeek = c.Int(nullable: false),
                        Description = c.String(maxLength: 1024),
                        Name = c.String(nullable: false, maxLength: 256),
                        Photo = c.String(),
                        Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                        RestaurantId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Restaurants", t => t.RestaurantId, cascadeDelete: true)
                .Index(t => t.RestaurantId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Dishes", "RestaurantId", "dbo.Restaurants");
            DropIndex("dbo.Dishes", new[] { "RestaurantId" });
            DropTable("dbo.Dishes");
        }
    }
}

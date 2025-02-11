namespace Hangfire.Dashboard
{
    public class NoAuthorizationFilter : Hangfire.Dashboard.IDashboardAuthorizationFilter
    {
        public bool Authorize(Hangfire.Dashboard.DashboardContext context) => true;
    }
}
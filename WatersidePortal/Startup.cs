using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WatersidePortal.Startup))]
namespace WatersidePortal
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

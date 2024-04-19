using Microsoft.AspNetCore.Mvc;

namespace KubernetesDummy.Web.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContentController : ControllerBase
    {
        [HttpGet]
        public ActionResult<string> Index() => Ok("Hello world from the content service! This has now changed!");

        [HttpGet("hello")]
        public ActionResult<string> Hello([FromQuery] string name) =>
            Ok($"Hello {name}, your request has been received by the content service!");
    }
}

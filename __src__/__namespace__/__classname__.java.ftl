<#if namespace?has_content && (namespace?length > 0) >
package ${namespace};
</#if>

import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.client.lyceum.LyceumClient;

/**
 * Classe que representa ...
 * 
 * @author tiago.romano
 * @version 1.0
 * @since 2016-10-19
 *
 */
@RestController
@RequestMapping(value = "/api/rest/LyceumListarDocentes")
public class ${classname} {

	/**
	 * Construtor
	 **/
	public ${classname}() {
	}
	
	
	@RequestMapping(method = RequestMethod.GET)   
  public String filter (
    @RequestParam(value="codigoDocente", required=false) String codigoDocente,
    @RequestParam(value="nomeCompletoDocente", required=false) String nomeCompletoDocente,
    @RequestParam(value="nomeDisciplina", required=false) String nomeDisciplina,
    @RequestParam(value="codigoFaculdadeDocenteUnidade", required=false) String codigoFaculdadeDocenteUnidade,
    @RequestParam(value="codigoDepartamentoDocenteUnidade", required=false) String codigoDepartamentoDocenteUnidade,
    @RequestParam(value="codigoFaculdade", required=false) String codigoFaculdade,
    @RequestParam(value="unidadeAtivaParaDocente", required=false) String unidadeAtivaParaDocente,
    @RequestParam(value="cpfPessoa", required=false) String cpfPessoa,
    @RequestParam(value="nomeMunicipioDocente", required=false) String nomeMunicipioDocente,
    @RequestParam(value="ufMunicipioDocente", required=false) String ufMunicipioDocente,
    @RequestParam(value="codigoTurmaDisciplina", required=false) String codigoTurmaDisciplina,
    @RequestParam(value="codigoPessoa", required=false) String codigoPessoa,
    @RequestParam(value="miniCurriculo", required=false) String miniCurriculo,
    @RequestParam(value="turmaDisciplinaAuxiliar", required=false) String turmaDisciplinaAuxiliar,
    @RequestParam(value="grauMinimo", required=false) String grauMinimo,
    @RequestParam(value="page", required=false) String page,
    @RequestParam(value="size", required=false) String size
    ){
      
    String filter = "";
    if (codigoDocente!=null && !codigoDocente.isEmpty())
      filter += "<codigoDocente>"+codigoDocente+"</codigoDocente>";
    if (nomeCompletoDocente!=null && !nomeCompletoDocente.isEmpty())
      filter += "<nomeCompletoDocente>"+nomeCompletoDocente+"</nomeCompletoDocente>";
    if (nomeDisciplina!=null && !nomeDisciplina.isEmpty())
      filter += "<nomeDisciplina>"+nomeDisciplina+"</nomeDisciplina>";
    if (codigoFaculdadeDocenteUnidade!=null && !codigoFaculdadeDocenteUnidade.isEmpty())
      filter += "<codigoFaculdadeDocenteUnidade>"+codigoFaculdadeDocenteUnidade+"</codigoFaculdadeDocenteUnidade>";
    if (codigoDepartamentoDocenteUnidade!=null && !codigoDepartamentoDocenteUnidade.isEmpty())
      filter += "<codigoDepartamentoDocenteUnidade>"+codigoDepartamentoDocenteUnidade+"</codigoDepartamentoDocenteUnidade>";
    if (codigoFaculdade!=null && !codigoFaculdade.isEmpty())
      filter += "<codigoFaculdade>"+codigoFaculdade+"</codigoFaculdade>";  
    if (unidadeAtivaParaDocente!=null && !unidadeAtivaParaDocente.isEmpty())
      filter += "<unidadeAtivaParaDocente>"+unidadeAtivaParaDocente+"</unidadeAtivaParaDocente>"; 
    if (cpfPessoa!=null && !cpfPessoa.isEmpty())
      filter += "<cpfPessoa>"+cpfPessoa+"</cpfPessoa>"; 
    if (nomeMunicipioDocente!=null && !nomeMunicipioDocente.isEmpty())
      filter += "<nomeMunicipioDocente>"+nomeMunicipioDocente+"</nomeMunicipioDocente>";
    if (ufMunicipioDocente!=null && !ufMunicipioDocente.isEmpty())
      filter += "<ufMunicipioDocente>"+ufMunicipioDocente+"</ufMunicipioDocente>";
    if (codigoTurmaDisciplina!=null && !codigoTurmaDisciplina.isEmpty())
      filter += "<codigoTurmaDisciplina>"+codigoTurmaDisciplina+"</codigoTurmaDisciplina>";
    if (codigoPessoa!=null && !codigoPessoa.isEmpty())
      filter += "<codigoPessoa>"+codigoPessoa+"</codigoPessoa>";
    if (miniCurriculo!=null && !miniCurriculo.isEmpty())
      filter += "<miniCurriculo>"+miniCurriculo+"</miniCurriculo>";
    if (turmaDisciplinaAuxiliar!=null && !turmaDisciplinaAuxiliar.isEmpty())
      filter += "<turmaDisciplinaAuxiliar>"+turmaDisciplinaAuxiliar+"</turmaDisciplinaAuxiliar>";
    if (grauMinimo!=null && !grauMinimo.isEmpty())
      filter += "<grauMinimo>"+grauMinimo+"</grauMinimo>";
    if (page!=null && !page.isEmpty() && size!=null && !size.isEmpty()) 
      filter += "<paginacaoDto><inicio>"+page+"</inicio><total>"+size+"</total></paginacaoDto>";
      
    JSONObject json = LyceumClient.getResult("http://uc.lyceum.com.br/WebServices/ServicoDocente","http://servicos/ServicoDocente/ListarDocentes",
          "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" >"
					+ " <soapenv:Header/>" + " <soapenv:Body>"
					+ "   <ListarDocentes xmlns=\"http://servicos.webservices.lyceum.techne/\">"
					+ "     <filtroDocentesDto xmlns=\"\">"
					+ filter
					+ "     </filtroDocentesDto>"
					+ "   </ListarDocentes>" + " </soapenv:Body>"
					+ "</soapenv:Envelope>");
					
					
		json = (JSONObject)json.get("soap:Envelope");
		json = (JSONObject)json.get("soap:Body");
		json = (JSONObject)json.get("ns2:ListarDocentesResponse");
		json = (JSONObject)json.get("listaInfoPrincipaisDocentesDto");
		
		
		int PRETTY_PRINT_INDENT_FACTOR = 4;
		String result = json.toString(PRETTY_PRINT_INDENT_FACTOR);
    return  result;    
  }

	

}
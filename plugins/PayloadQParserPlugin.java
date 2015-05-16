package payloadexample;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.payloads.AveragePayloadFunction;
import org.apache.lucene.search.payloads.PayloadTermQuery;
import org.apache.solr.common.params.CommonParams;
import org.apache.solr.common.params.SolrParams;
import org.apache.solr.common.util.NamedList;
import org.apache.solr.parser.QueryParser;
import org.apache.solr.request.SolrQueryRequest;
import org.apache.solr.schema.SchemaField;
import org.apache.solr.search.QParser;
import org.apache.solr.search.QParserPlugin;
import org.apache.solr.search.QueryParsing;
import org.apache.solr.search.SyntaxError;

// Just the factory class that doesn't do very much in this 
// case but is necessary for registration in solrconfig.xml.
public class PayloadQParserPlugin extends QParserPlugin {

  @Override
  public void init(NamedList args) {
    // Might want to do something here if you want to preserve information for subsequent calls!
  }

  @Override
  public QParser createParser(String qstr, SolrParams localParams, SolrParams params, SolrQueryRequest req) {
    return new PayloadQParser(qstr, localParams, params, req);
  }
}


// The actual parser. Note that it relies heavily on the superclass
class PayloadQParser extends QParser {
  PayloadQueryParser pqParser;

  public PayloadQParser(String qstr, SolrParams localParams, SolrParams params, SolrQueryRequest req) {
    super(qstr, localParams, params, req);
  }

  // This is kind of tricky. The deal here is that you do NOT 
  // want to get into all the process of parsing parentheses,
  // operators like AND/OR/NOT/+/- etc, it's difficult. So we'll 
  // let the default parsing do all this for us.
  // Eventually the complex logic will resolve to asking for 
  // fielded query, which we define in the PayloadQueryParser
  // below.
  @Override
  public Query parse() throws SyntaxError {
    String qstr = getString();
    if (qstr == null || qstr.length() == 0) return null;

    String defaultField = getParam(CommonParams.DF);
    if (defaultField == null) {
      defaultField = getReq().getSchema().getDefaultSearchFieldName();
    }
    pqParser = new PayloadQueryParser(this, defaultField);

    pqParser.setDefaultOperator
        (QueryParsing.getQueryParserDefaultOperator(getReq().getSchema(),
            getParam(QueryParsing.OP)));

    return pqParser.parse(qstr);
  }

  @Override
  public String[] getDefaultHighlightFields() {
    return pqParser == null ? new String[]{} :
                              new String[] {pqParser.getDefaultField()};
  }

}


// Here's the tricky bit. You let the methods defined in the 
// superclass do the heavy lifting, parsing all the
// parentheses/AND/OR/NOT/+/- whatever. Then, eventually, when 
// all that's resolved down to a field and a term, and
// BOOM, you're here at the simple "getFieldQuery" call.
// NOTE: this is not suitable for phrase queries, the limitation 
// here is that we're only evaluating payloads for
// queries that can resolve to combinations of single word 
// fielded queries.
class PayloadQueryParser extends QueryParser {
  PayloadQueryParser(QParser parser, String defaultField) {
    super(parser.getReq().getCore().getSolrConfig().luceneMatchVersion, defaultField, parser);
  }

  @Override
  protected Query getFieldQuery(String field, String queryText, boolean quoted) throws SyntaxError {
    SchemaField sf = this.schema.getFieldOrNull(field);
    // Note that this will work for any field defined with the
    // <fieldType> of "payloads", not just the field "payloads".
    // One could easily parameterize this in the config files to
    // avoid hard-coding the values.
    if (sf != null && sf.getType().getTypeName().equalsIgnoreCase("payloads")) {
      return new PayloadTermQuery(new Term(field, queryText.toLowerCase()), new AveragePayloadFunction(), true);
    }
    return super.getFieldQuery(field, queryText.toLowerCase(), quoted);
  }
}
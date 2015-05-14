package payloadexample;

import java.util.HashMap;
import java.util.Map;

import org.apache.lucene.index.FieldInvertState;
import org.apache.lucene.index.LeafReaderContext;
import org.apache.lucene.search.CollectionStatistics;
import org.apache.lucene.search.Explanation;
import org.apache.lucene.search.TermStatistics;
import org.apache.lucene.util.BytesRef;
import org.apache.lucene.analysis.payloads.PayloadHelper;
import org.apache.lucene.search.similarities.DefaultSimilarity;
import org.apache.lucene.search.similarities.Similarity;
import org.apache.solr.common.params.SolrParams;
import org.apache.solr.schema.SimilarityFactory;



public class PayloadSimilarityFactory extends SimilarityFactory {
  @Override
  public void init(SolrParams params) {
    super.init(params);
  }

  @Override
  public Similarity getSimilarity() {
    return new PayloadSimilarity();
  }
}

class PayloadSimilarity extends DefaultSimilarity {

  //Here's where we actually decode the payload and return it.
  @Override
  public float scorePayload(int doc, int start, int end, BytesRef payload) {
    if (payload == null) return 1.0F;
    return PayloadHelper.decodeFloat(payload.bytes, payload.offset);
  }
}


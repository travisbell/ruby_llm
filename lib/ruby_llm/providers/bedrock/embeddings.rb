# frozen_string_literal: true

module RubyLLM
  module Providers
    class Bedrock
      # Embeddings methods of the Bedrock integration
      module Embeddings
        module_function

        def embedding_url(model:)
          "/model/#{model}/invoke"
        end

        def render_embedding_payload(text, model:, dimensions:)
          {
            dimensions: dimensions,
            inputText: text,
            normalize: true
          }.compact
        end

        def parse_embedding_response(response, model:, text:)
          data = response.body
          input_tokens = data.dig('inputTextTokenCount') || 0
          vectors = data.dig('embedding')
          Embedding.new(vectors:, model:, input_tokens:)
        end
      end
    end
  end
end

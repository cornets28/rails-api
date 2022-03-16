require 'rails_helper'

# bundle exec rspec ./spec/requests/articles_spec.rb

RSpec.describe ArticlesController do
    describe '#index' do
        it 'returns a success response' do
            get '/articles'
            expect(response).to have_http_status(:ok)
        end

        it 'returns a proper json' do
            article = create :article
            get '/articles'

            aggregate_failures do
                expect(json_data.length).to eq(1)
                expected = json_data.first
                expect(expected[:id]).to eq(article.id.to_s)
                expect(expected[:type]).to eq('article')
                expect(expected[:attributes]).to eq(
                    title: article.title,
                    content: article.content,
                    slug: article.slug      
                )
            end
        end
    end
end
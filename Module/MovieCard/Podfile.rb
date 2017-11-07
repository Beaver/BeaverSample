def movie_card_pods
    # Put your target dependencies here
end

def movie_card_target
    target 'MovieCard' do
        core_pods
        movie_card_pods

        target 'MovieCardTests' do
            inherit! :search_paths

            test_pods
        end
    end
end

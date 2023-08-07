GIT_URL=git@git.ridotto.by:bbsoft/bbsoft-client.git
BRANCH=default-branch-main
REGISTRY_URL=registry.prod.default
REGISTRY_PROJECT=default-project-name
SERVICE=default-service-name


build:
	if [ -d $(SERVICE) ]; then rm -rf $(SERVICE); fi
	git clone $(GIT_URL) -b $(BRANCH)
	if echo $(BRANCH) | grep -q '[а-яА-Я]'; then \
          echo "BRANCH - $(BRANCH) contaion russian words" ; \
		  echo "Merge branch into new BRANCH without russian words" ; \
		  exit  1; \
        else \
          echo "BRANCH doesn't contain russian words"; \
	  docker build -t $(REGISTRY_URL)/$(REGISTRY_PROJECT)/$(SERVICE):$(BRANCH)-$(CI_COMMIT_SHORT_SHA) $(SERVICE); \
	  docker push ${REGISTRY_URL}/${REGISTRY_PROJECT}/$(SERVICE):${BRANCH}-${CI_COMMIT_SHORT_SHA} ; \
        fi
	
	rm -rf $(SERVICE)

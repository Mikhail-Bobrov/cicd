GIT_URL=git@git.ridotto.by:lottery/api-gateway.git
BRANCH=main
REGISTRY_URL=registry.prerod.loto
REGISTRY_PROJECT=bbsoft-dev
SERVICE=bbsoft-client
JAVA_VERSION=registry.ridotto.by/bbsoft/bbsoft-ci:zulu-openjdk14


build:
	if [ -d $(SERVICE) ]; then rm -rf $(SERVICE); fi
	git clone $(GIT_URL) -b $(BRANCH)
	if echo $(BRANCH) | grep -q '[а-яА-Я]'; then \
          echo "BRANCH - $(BRANCH) contaion russian words" ; \
		  echo "Merge branch into new BRANCH without russian words" ; \
		  exit  1; \
        else \
          echo "BRANCH doesn't contain russian words"; \
	  docker build --build-arg JAVA_VERSION=${JAVA_VERSION} -t $(REGISTRY_URL)/$(REGISTRY_PROJECT)/$(SERVICE):$(BRANCH)-$(CI_COMMIT_SHORT_SHA) .; \
	  docker push ${REGISTRY_URL}/${REGISTRY_PROJECT}/$(SERVICE):${BRANCH}-${CI_COMMIT_SHORT_SHA} ; \
        fi
	
	rm -rf $(SERVICE)
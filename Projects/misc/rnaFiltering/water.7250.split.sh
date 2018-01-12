ls out/7200.good.pair/ | perl -pe 's|.+|split -l 100000 out/7200.good.pair/$& out/7250.split/$&.|'

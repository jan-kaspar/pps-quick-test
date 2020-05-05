import root;
import pad_layout;

string periods[], p_runs[];
periods.push("2016_preTS2"); p_runs.push("275371");
periods.push("2016_postTS2"); p_runs.push("283453");

periods.push("2017_preTS2"); p_runs.push("301283");
periods.push("2017_postTS2"); p_runs.push("305081");

periods.push("2017E_low_PU"); p_runs.push("303819");
periods.push("2017H_W_mass"); p_runs.push("307082");

periods.push("2018"); p_runs.push("320688");
periods.push("2018A"); p_runs.push("315489");
periods.push("2018B"); p_runs.push("317435");
periods.push("2018C"); p_runs.push("319450");
periods.push("2018D"); p_runs.push("320822");

string plots[], pl_sectors[], pl_paths[];
int pl_rebin[];
plots.push("$\xi$"); pl_sectors.push("45"); pl_paths.push("multiRPPlots/arm0/h_xi"); pl_rebin.push(2);
plots.push("$\th^*_x\ung{rad}$"); pl_sectors.push("45"); pl_paths.push("multiRPPlots/arm0/h_th_x"); pl_rebin.push(5);
plots.push("$\th^*_y\ung{rad}$"); pl_sectors.push("45"); pl_paths.push("multiRPPlots/arm0/h_th_y"); pl_rebin.push(5);
//plots.push("$|t|\ung{GeV^2}$"); pl_sectors.push("45"); pl_paths.push("multiRPPlots/arm0/h_t"); pl_rebin.push(2);
plots.push("n timing-RP tracks"); pl_sectors.push("45"); pl_paths.push("multiRPPlots/arm0/h_n_contrib_timing_tracks"); pl_rebin.push(1);
plots.push("time"); pl_sectors.push("45"); pl_paths.push("multiRPPlots/arm0/h_time"); pl_rebin.push(1);

plots.push("$\xi$"); pl_sectors.push("56"); pl_paths.push("multiRPPlots/arm1/h_xi"); pl_rebin.push(2);
plots.push("$\th^*_x\ung{rad}$"); pl_sectors.push("56"); pl_paths.push("multiRPPlots/arm1/h_th_x"); pl_rebin.push(5);
plots.push("$\th^*_y\ung{rad}$"); pl_sectors.push("56"); pl_paths.push("multiRPPlots/arm1/h_th_y"); pl_rebin.push(5);
//plots.push("$|t|\ung{GeV^2}$"); pl_sectors.push("56"); pl_paths.push("multiRPPlots/arm1/h_t"); pl_rebin.push(2);
plots.push("n timing-RP tracks"); pl_sectors.push("56"); pl_paths.push("multiRPPlots/arm1/h_n_contrib_timing_tracks"); pl_rebin.push(1);
plots.push("time"); pl_sectors.push("56"); pl_paths.push("multiRPPlots/arm1/h_time"); pl_rebin.push(1);

string dirs[], d_labels[];
pen d_pens[];

dirs.push("version_1"); d_pens.push(blue); d_labels.push("at 18c0cc1d171, GT 106X_dataRun2_v26");
//dirs.push("version_2"); d_pens.push(red+dashed); d_labels.push("at 18c0cc1d171, GT 106X_dataRun2_v26, alignment local");
//dirs.push("version_3"); d_pens.push(red+dashed); d_labels.push("at c8bdd25133c, GT 106X_dataRun2_v26, alignment local");
//dirs.push("version_4"); d_pens.push(red+dashed); d_labels.push("at 00ecea5b2ac, GT 106X_dataRun2_v26, alignment local");
//dirs.push("version_5"); d_pens.push(red+dashed); d_labels.push("at 1ea5bb2a74a, GT 106X_dataRun2_v26, alignment local");

// submission scripts updated

//dirs.push("version_6"); d_pens.push(red+dashed); d_labels.push("at 290f4fb7afd, GT 106X_dataRun2_v26");
//dirs.push("version_7"); d_pens.push(red+dashed); d_labels.push("at 290f4fb7afd, GT 106X_dataRun2_v26, alignment local; devel flag");
//dirs.push("version_8"); d_pens.push(red+dashed); d_labels.push("at bf100e3ff0a, GT 106X_dataRun2_v26, alignment local; devel flag");
//dirs.push("version_9"); d_pens.push(red+dashed); d_labels.push("at 25debe6ab6b, GT 106X_dataRun2_v26, alignment local; devel flag");

dirs.push("version_10"); d_pens.push(red+dashed); d_labels.push("at 9f831ddc2e7, GT 106X_dataRun2_v26, alignment local; optics local; devel flag");

xSizeDef = 8cm;
ySizeDef = 8cm;

//----------------------------------------------------------------------------------------------------

NewPad(false);
for (int di : dirs.keys)
	//AddToLegend(replace(dirs[di] + ": " + d_labels[di], "_", "\_"), d_pens[di]);
	AddToLegend(replace(d_labels[di], "_", "\_"), d_pens[di]);
AttachLegend();

for (int pli : plots.keys)
	NewPadLabel("\vbox{\hbox{sector " + pl_sectors[pli] + "}\hbox{" + plots[pli] + "}}");

//----------------------------------------------------------------------------------------------------

for (int peri : periods.keys)
{
	NewRow();

	NewPadLabel("\vbox{\hbox{" + replace(periods[peri], "_", "\_") + "}\hbox{(subsample of run " + p_runs[peri] + ")}}");

	string f_old = "/afs/cern.ch/work/j/jkaspar/software/ctpps/development/ctpps_initial_proton_reconstruction_CMSSW_10_2_0/CMSSW_10_2_0/src/forward-test/reco_plots_" + periods[peri] + ".root";
	//string f_new = "DQM_V0001_CTPPS_R000" + p_runs[peri] + ".root";
	string f_new = "reco_plots_" + periods[peri] + ".root";

	for (int pli : plots.keys)
	{
		NewPad(plots[pli]);

		for (int diri : dirs.keys)
		{
			string f = dirs[diri] + "/" + periods[peri] + "_reco_plots.root";

			RootObject hist = RootGetObject(f, pl_paths[pli], error=false);
			if (!hist.valid)
				continue;

			hist.vExec("Rebin", pl_rebin[pli]);

			draw(hist, "vl", d_pens[diri]);
		}

		AttachLegend("sector " + pl_sectors[pli]);
	}
}

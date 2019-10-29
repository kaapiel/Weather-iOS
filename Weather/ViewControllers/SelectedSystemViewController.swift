//
//  SystemSelectedViewController.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 04/10/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import UIKit
import Charts

class SelectedSystemViewController: UIViewController {
    
    var scoreHistory: ScoreHistory?
    var allScores = [ScoreResult]()
    var jiraUser: JiraUser?
    var system: ScoreResult?
    var systems: [ScoreResult]?
    @IBOutlet weak var halfPieChart: HalfPieChartViewController!
    @IBOutlet weak var lineChart: LineChartViewController!
    @IBOutlet weak var barChart: BarChartViewController!
    @IBOutlet weak var horizontalBarChart: HorizontalBarChartViewController!
    @IBOutlet weak var sysName: UILabel!
    @IBOutlet weak var issuesNumber: UILabel!
    @IBOutlet weak var linesNumber: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var nloc: UILabel!
    @IBOutlet weak var totalIssues: UILabel!
    @IBOutlet weak var openIssues: UILabel!
    @IBOutlet weak var duplications: UILabel!
    @IBOutlet weak var coverage: UILabel!
    @IBOutlet weak var taxaDeSucesso: UILabel!
    @IBOutlet weak var execucoesOk: UILabel!
    @IBOutlet weak var casosDeTeste: UILabel!
    @IBOutlet weak var totalDeExecucoes: UILabel!
    @IBOutlet weak var densidadeDeDefeitos: UILabel!
    @IBOutlet weak var defeitosAbertos: UILabel!
    @IBOutlet weak var totalDeDefeitos: UILabel!
    @IBOutlet weak var AgingMedio: UILabel!
    @IBOutlet weak var eficacia: UILabel!
    @IBOutlet weak var incidentes: UILabel!
    @IBOutlet weak var problemas: UILabel!
    @IBOutlet weak var fixTimeMedio: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBAction func onShareButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Weather", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
        newViewController.allScores = allScores
        newViewController.scores = allScores
        newViewController.jiraUser = jiraUser
        present(newViewController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupData()
    }
    
    func configureView() {
        applyGradient()
        scrollView.isScrollEnabled = true
    }
    
    func setupData() {
        score.text = system?.score.description
        sysName.text = system?.applicationName
        linesNumber.text = system?.ncloc.roundedWithAbbreviations
        issuesNumber.text = system?.totalIssues.roundedWithAbbreviations
        lastUpdated.text = "Atualizado por último em \(LegacyCalls().getLastUpdated(scores: self.systems!))"
        
        //Code inspection
        nloc.text = system?.ncloc.roundedWithAbbreviations
        totalIssues.text = system?.totalIssues.description
        openIssues.text = system?.openIssues.description
        coverage.text = "\(system?.coverage.description ?? "00.0%")%"
        duplications.text = "\(system?.duplicationDensity.description ?? "00.0%")%"
        
        //Functional Tests
        casosDeTeste.text = system?.testsCase.description
        totalDeExecucoes.text = system?.totalTestExecutions.description
        execucoesOk.text = system?.executionsPassed.description
        taxaDeSucesso.text = "\(system?.successRate.description ?? "00.0%")%"
        densidadeDeDefeitos.text = "\(system?.defectsDensity.description ?? "00.0%")%"
        
        //Defects
        defeitosAbertos.text = system?.openDefects.description
        AgingMedio.text = system?.averageAge.description
        totalDeDefeitos.text = system?.totalDefects.description
        fixTimeMedio.text = system?.averageTimeFix.description
        
        //Functional Efficiency
        problemas.text = system?.totalProblems.description
        //incidentes.text = system?.totalIncidents.description
        eficacia.text = "\(system?.effectiveness.description ?? "00.0%")%"
    }
    
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = viewContainer.bounds
        
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 0/255.0, green: 171/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        ]
        
        gradientLayer.shouldRasterize = true
        viewContainer.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "halfPieChartSegue" {
            self.halfPieChart = segue.destination as? HalfPieChartViewController
            self.halfPieChart.scoreResult = system
        } else if segue.identifier == "lineChartSegue" {
            self.lineChart = segue.destination as? LineChartViewController
            self.lineChart.scoreHistory = scoreHistory
        } else if segue.identifier == "horizontalBarChartSegue" {
            self.horizontalBarChart = segue.destination as? HorizontalBarChartViewController
            self.horizontalBarChart.scoreResult = system
        } else if segue.identifier == "verticalBarChartSegue" {
            self.barChart = segue.destination as? BarChartViewController
            self.barChart.scoreResult = system
        }
        
    }
    
}
